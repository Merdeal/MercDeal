-- MercDeal - server-authoritative marketplace logic
-- Apply after supabase/schema.sql.

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

do $$
declare
  t text;
begin
  foreach t in array array[
    'profiles','seller_verifications','listings','auctions','offers','orders','shipments',
    'meetups','messages','notifications','subscriptions','authenticity_checks','showcases',
    'disputes'
  ] loop
    execute format('drop trigger if exists %I_updated_at on public.%I', t, t);
    execute format('create trigger %I_updated_at before update on public.%I for each row execute function public.set_updated_at()', t, t);
  end loop;
end $$;

-- Automatically create a public profile when a new Auth user is created.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, display_name, email_verified)
  values (
    new.id,
    coalesce(nullif(new.raw_user_meta_data ->> 'display_name', ''), split_part(coalesce(new.email, ''), '@', 1)),
    coalesce(new.email_confirmed_at is not null, false)
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute function public.handle_new_user();

-- Calculates the current public auction price from the server clock.
-- The minimum price is never returned.
create or replace function public.current_auction_price(p_listing_id uuid)
returns integer
language plpgsql
stable
security definer set search_path = public
as $$
declare
  l listings%rowtype;
  v_days integer;
  v_price integer;
begin
  select * into l from public.listings where id = p_listing_id and sale_mode = 'descending_auction';
  if not found then
    raise exception 'AUCTION_NOT_FOUND';
  end if;
  if l.published_at is null then
    return l.start_price_cents;
  end if;

  v_days := greatest(0, floor(extract(epoch from (least(now(), coalesce(l.expires_at, now())) - l.published_at)) / 86400)::integer);
  v_price := greatest(l.minimum_price_cents, l.start_price_cents - (v_days * 20));
  return v_price;
end;
$$;

-- Refreshes the materialized auction row and keeps the price server-authoritative.
create or replace function public.refresh_auction(p_listing_id uuid)
returns public.auctions
language plpgsql
security definer set search_path = public
as $$
declare
  l listings%rowtype;
  a public.auctions%rowtype;
  v_price integer;
  v_reached boolean;
  v_next timestamptz;
begin
  select * into l from public.listings where id = p_listing_id and sale_mode = 'descending_auction' for update;
  if not found then raise exception 'AUCTION_NOT_FOUND'; end if;
  v_price := public.current_auction_price(p_listing_id);
  v_reached := v_price <= l.minimum_price_cents;
  v_next := case
    when v_reached or l.published_at is null then null
    else l.published_at + ((floor(extract(epoch from (now() - l.published_at)) / 86400)::integer + 1) * interval '1 day')
  end;

  insert into public.auctions(listing_id,current_price_cents,decrement_cents,next_drop_at,minimum_reached)
  values (l.id, v_price, 20, v_next, v_reached)
  on conflict (listing_id) do update set
    current_price_cents = excluded.current_price_cents,
    next_drop_at = excluded.next_drop_at,
    minimum_reached = excluded.minimum_reached,
    updated_at = now()
  returning * into a;
  return a;
end;
$$;

-- Buyer offer: validates seller/buyer/listing, records shipping quote and total,
-- and locks the listing so two concurrent accepted flows cannot race locally.
create or replace function public.place_offer(
  p_listing_id uuid,
  p_amount_cents integer,
  p_shipping_quote_cents integer default 0
)
returns public.offers
language plpgsql
security definer set search_path = public
as $$
declare
  l listings%rowtype;
  v_offer public.offers%rowtype;
  v_total integer;
  v_current integer;
begin
  if auth.uid() is null then raise exception 'AUTH_REQUIRED'; end if;
  if p_amount_cents <= 0 or p_shipping_quote_cents < 0 then raise exception 'INVALID_AMOUNT'; end if;

  select * into l from public.listings where id = p_listing_id for update;
  if not found or l.status <> 'active' then raise exception 'LISTING_NOT_ACTIVE'; end if;
  if l.seller_id = auth.uid() then raise exception 'SELLER_CANNOT_OFFER'; end if;

  if l.sale_mode = 'descending_auction' then
    perform public.refresh_auction(l.id);
    select current_price_cents into v_current from public.auctions where listing_id = l.id;
    -- An offer can be below the current public price; never above it for an auction offer.
    if p_amount_cents > v_current then raise exception 'OFFER_ABOVE_CURRENT_PRICE'; end if;
  end if;

  v_total := p_amount_cents + p_shipping_quote_cents;
  insert into public.offers(listing_id,buyer_id,seller_id,amount_cents,shipping_quote_cents,total_cents)
  values (l.id,auth.uid(),l.seller_id,p_amount_cents,p_shipping_quote_cents,v_total)
  returning * into v_offer;
  return v_offer;
end;
$$;

-- Keep private seller minimums out of public table reads. The public auction table
-- only contains the current price and derived state.
revoke all on function public.current_auction_price(uuid) from public;
revoke all on function public.refresh_auction(uuid) from public;
revoke all on function public.place_offer(uuid,integer,integer) from public;
grant execute on function public.current_auction_price(uuid) to authenticated;
grant execute on function public.refresh_auction(uuid) to authenticated;
grant execute on function public.place_offer(uuid,integer,integer) to authenticated;

-- A buyer may create an offer, but may not update its amount/status directly.
drop policy if exists offers_buyer_insert on public.offers;
create policy offers_buyer_insert on public.offers
for insert with check (buyer_id = auth.uid());

-- Prevent clients from changing auction materialized state directly.
drop policy if exists auctions_client_write on public.auctions;

-- Orders are created by trusted server functions only; clients can read their own orders.
drop policy if exists orders_participant_insert on public.orders;

-- Private report dossier can be read by reporter; inserts require reporter identity.
-- Resolution remains server/admin controlled.
