-- MercDeal production-oriented database foundation.
-- Run through Supabase migrations, not from the Flutter client.

create extension if not exists pgcrypto;

create type public.sale_mode as enum ('buy_now','descending_auction','offer');
create type public.listing_status as enum ('draft','active','reserved','sold','expired','cancelled');
create type public.offer_status as enum ('pending','accepted','rejected','countered','expired','withdrawn');
create type public.order_status as enum ('pending_payment','paid','shipping','delivered','inspection','completed','disputed','cancelled','pickup_scheduled');
create type public.delivery_method as enum ('shipping','hand_pickup');
create type public.verification_status as enum ('unverified','pending','verified','rejected');

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null default '',
  avatar_url text,
  email_verified boolean not null default false,
  phone_verified boolean not null default false,
  seller_verification verification_status not null default 'unverified',
  rating numeric(3,2),
  review_count integer not null default 0,
  completed_deals integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.seller_verifications (
  user_id uuid primary key references public.profiles(id) on delete cascade,
  legal_first_name text,
  legal_last_name text,
  address_line text,
  postal_code text,
  city text,
  country_code text default 'IT',
  phone_e164 text,
  tax_code text,
  payment_provider_user_id text,
  payment_provider_recipient_id text,
  payment_provider_wallet_id text,
  kyc_status verification_status not null default 'unverified',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.listings (
  id uuid primary key default gen_random_uuid(),
  seller_id uuid not null references public.profiles(id),
  title text not null,
  description text not null default '',
  category text not null,
  condition text not null,
  sale_mode public.sale_mode not null,
  status public.listing_status not null default 'draft',
  price_cents integer not null check (price_cents >= 0),
  start_price_cents integer check (start_price_cents is null or start_price_cents >= 0),
  minimum_price_cents integer check (minimum_price_cents is null or minimum_price_cents >= 0),
  duration_days integer check (duration_days in (7,15,30)),
  published_at timestamptz,
  expires_at timestamptz,
  weight_grams integer check (weight_grams is null or weight_grams > 0),
  length_cm numeric(7,2),
  width_cm numeric(7,2),
  height_cm numeric(7,2),
  shipping_enabled boolean not null default true,
  pickup_enabled boolean not null default false,
  authenticity_state text not null default 'not_verified',
  showcase_until timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint auction_fields check (
    (sale_mode <> 'descending_auction') or
    (start_price_cents is not null and minimum_price_cents is not null and duration_days is not null and start_price_cents >= minimum_price_cents)
  )
);

create table public.listing_media (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid not null references public.listings(id) on delete cascade,
  storage_path text not null,
  media_type text not null check (media_type in ('image','video')),
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create table public.auctions (
  listing_id uuid primary key references public.listings(id) on delete cascade,
  current_price_cents integer not null,
  decrement_cents integer not null default 20 check (decrement_cents = 20),
  next_drop_at timestamptz,
  minimum_reached boolean not null default false,
  updated_at timestamptz not null default now()
);

create table public.offers (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid not null references public.listings(id) on delete cascade,
  buyer_id uuid not null references public.profiles(id),
  seller_id uuid not null references public.profiles(id),
  amount_cents integer not null check (amount_cents > 0),
  shipping_quote_cents integer,
  total_cents integer,
  status public.offer_status not null default 'pending',
  parent_offer_id uuid references public.offers(id),
  expires_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.favorites (
  user_id uuid not null references public.profiles(id) on delete cascade,
  listing_id uuid not null references public.listings(id) on delete cascade,
  target_price_cents integer,
  created_at timestamptz not null default now(),
  primary key (user_id, listing_id)
);

create table public.saved_searches (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  query text not null,
  filters jsonb not null default '{}'::jsonb,
  alerts_enabled boolean not null default true,
  created_at timestamptz not null default now()
);

create table public.orders (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid not null references public.listings(id),
  seller_id uuid not null references public.profiles(id),
  buyer_id uuid not null references public.profiles(id),
  sale_mode public.sale_mode not null,
  delivery_method public.delivery_method not null,
  item_price_cents integer not null,
  shipping_cents integer not null default 0,
  protection_cents integer not null default 0,
  total_cents integer not null,
  status public.order_status not null default 'pending_payment',
  terms_snapshot jsonb not null default '{}'::jsonb,
  paid_at timestamptz,
  delivered_at timestamptz,
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.shipments (
  id uuid primary key default gen_random_uuid(),
  order_id uuid unique not null references public.orders(id) on delete cascade,
  provider text,
  service_code text,
  label_storage_path text,
  tracking_code text,
  tracking_url text,
  quote_cents integer not null default 0,
  carrier_status text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.meetups (
  id uuid primary key default gen_random_uuid(),
  order_id uuid unique not null references public.orders(id) on delete cascade,
  meeting_lat numeric(10,7),
  meeting_lng numeric(10,7),
  meeting_label text,
  scheduled_at timestamptz,
  seller_arrived_at timestamptz,
  buyer_arrived_at timestamptz,
  location_sharing_started_at timestamptz,
  location_sharing_ended_at timestamptz,
  seller_confirmed boolean not null default false,
  buyer_confirmed boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.conversations (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid references public.listings(id),
  order_id uuid references public.orders(id),
  created_at timestamptz not null default now()
);

create table public.conversation_members (
  conversation_id uuid not null references public.conversations(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  primary key (conversation_id, user_id)
);

create table public.messages (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.conversations(id) on delete cascade,
  sender_id uuid not null references public.profiles(id),
  body text not null,
  attachment_path text,
  created_at timestamptz not null default now()
);

create table public.packing_videos (
  id uuid primary key default gen_random_uuid(),
  order_id uuid unique not null references public.orders(id) on delete cascade,
  seller_id uuid not null references public.profiles(id),
  storage_path text not null,
  duration_seconds integer not null check (duration_seconds between 1 and 60),
  created_at timestamptz not null default now()
);

create table public.security_seals (
  id uuid primary key default gen_random_uuid(),
  order_id uuid unique not null references public.orders(id) on delete cascade,
  unique_code text not null unique,
  qr_payload text not null,
  storage_path text,
  created_at timestamptz not null default now()
);

create table public.reviews (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  reviewer_id uuid not null references public.profiles(id),
  reviewed_user_id uuid not null references public.profiles(id),
  rating integer not null check (rating between 1 and 5),
  communication_rating integer check (communication_rating between 1 and 5),
  conformity_rating integer check (conformity_rating between 1 and 5),
  punctuality_rating integer check (punctuality_rating between 1 and 5),
  body text,
  created_at timestamptz not null default now(),
  unique(order_id, reviewer_id)
);

create table public.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  kind text not null,
  title text not null,
  body text not null,
  data jsonb not null default '{}'::jsonb,
  read_at timestamptz,
  created_at timestamptz not null default now()
);

create table public.subscriptions (
  user_id uuid primary key references public.profiles(id) on delete cascade,
  plan text not null default 'free' check (plan in ('free','deal_plus_monthly','deal_plus_yearly')),
  provider_customer_id text,
  provider_subscription_id text,
  status text not null default 'inactive',
  current_period_end timestamptz,
  updated_at timestamptz not null default now()
);

create table public.authenticity_checks (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid unique not null references public.listings(id) on delete cascade,
  seller_id uuid not null references public.profiles(id),
  state text not null default 'not_verified' check (state in ('not_verified','documents_provided','verified','rejected')),
  private_evidence jsonb not null default '{}'::jsonb,
  reviewer_notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.showcases (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid not null references public.listings(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  starts_at timestamptz not null,
  ends_at timestamptz not null,
  created_at timestamptz not null default now(),
  check (ends_at > starts_at)
);

create table public.disputes (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  opened_by uuid not null references public.profiles(id),
  reason text not null,
  evidence jsonb not null default '{}'::jsonb,
  status text not null default 'open',
  resolution text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.reports (
  id uuid primary key default gen_random_uuid(),
  reporter_id uuid not null references public.profiles(id),
  order_id uuid references public.orders(id),
  listing_id uuid references public.listings(id),
  reason text not null,
  dossier jsonb not null default '{}'::jsonb,
  user_approved boolean not null default false,
  created_at timestamptz not null default now()
);

create index listings_active_idx on public.listings(status, category, created_at desc);
create index listings_drop_idx on public.listings(sale_mode, status, updated_at desc);
create index offers_listing_idx on public.offers(listing_id, created_at desc);
create index orders_buyer_idx on public.orders(buyer_id, created_at desc);
create index orders_seller_idx on public.orders(seller_id, created_at desc);
create index notifications_user_idx on public.notifications(user_id, created_at desc);
create index messages_conversation_idx on public.messages(conversation_id, created_at desc);

-- RLS baseline. Sensitive seller verification and payment identifiers remain private.
alter table public.profiles enable row level security;
alter table public.seller_verifications enable row level security;
alter table public.listings enable row level security;
alter table public.listing_media enable row level security;
alter table public.auctions enable row level security;
alter table public.offers enable row level security;
alter table public.favorites enable row level security;
alter table public.saved_searches enable row level security;
alter table public.orders enable row level security;
alter table public.shipments enable row level security;
alter table public.meetups enable row level security;
alter table public.conversations enable row level security;
alter table public.conversation_members enable row level security;
alter table public.messages enable row level security;
alter table public.packing_videos enable row level security;
alter table public.security_seals enable row level security;
alter table public.reviews enable row level security;
alter table public.notifications enable row level security;
alter table public.subscriptions enable row level security;
alter table public.authenticity_checks enable row level security;
alter table public.showcases enable row level security;
alter table public.disputes enable row level security;
alter table public.reports enable row level security;

create policy profiles_public_read on public.profiles for select using (true);
create policy profiles_self_write on public.profiles for update using (auth.uid() = id) with check (auth.uid() = id);
create policy seller_verification_self_read on public.seller_verifications for select using (auth.uid() = user_id);
create policy seller_verification_self_write on public.seller_verifications for insert with check (auth.uid() = user_id);
create policy seller_verification_self_update on public.seller_verifications for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy listings_public_read on public.listings for select using (status = 'active' or seller_id = auth.uid());
create policy listings_owner_insert on public.listings for insert with check (seller_id = auth.uid());
create policy listings_owner_update on public.listings for update using (seller_id = auth.uid()) with check (seller_id = auth.uid());
create policy listings_owner_delete on public.listings for delete using (seller_id = auth.uid());

create policy media_public_read on public.listing_media for select using (exists (select 1 from public.listings l where l.id = listing_id and (l.status = 'active' or l.seller_id = auth.uid())));
create policy media_owner_write on public.listing_media for all using (exists (select 1 from public.listings l where l.id = listing_id and l.seller_id = auth.uid())) with check (exists (select 1 from public.listings l where l.id = listing_id and l.seller_id = auth.uid()));

create policy auctions_public_read on public.auctions for select using (exists (select 1 from public.listings l where l.id = listing_id and (l.status = 'active' or l.seller_id = auth.uid())));
create policy favorites_self on public.favorites for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy saved_searches_self on public.saved_searches for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy offers_participant_read on public.offers for select using (buyer_id = auth.uid() or seller_id = auth.uid());
create policy offers_buyer_insert on public.offers for insert with check (buyer_id = auth.uid());

create policy orders_participant_read on public.orders for select using (buyer_id = auth.uid() or seller_id = auth.uid());
create policy shipments_order_participant on public.shipments for select using (exists (select 1 from public.orders o where o.id = order_id and (o.buyer_id = auth.uid() or o.seller_id = auth.uid())));
create policy meetups_order_participant on public.meetups for select using (exists (select 1 from public.orders o where o.id = order_id and (o.buyer_id = auth.uid() or o.seller_id = auth.uid())));
create policy meetups_order_update on public.meetups for update using (exists (select 1 from public.orders o where o.id = order_id and (o.buyer_id = auth.uid() or o.seller_id = auth.uid())));

create policy conversation_member_read on public.conversations for select using (exists (select 1 from public.conversation_members cm where cm.conversation_id = id and cm.user_id = auth.uid()));
create policy member_self_read on public.conversation_members for select using (user_id = auth.uid());
create policy messages_member_read on public.messages for select using (exists (select 1 from public.conversation_members cm where cm.conversation_id = conversation_id and cm.user_id = auth.uid()));
create policy messages_member_insert on public.messages for insert with check (sender_id = auth.uid() and exists (select 1 from public.conversation_members cm where cm.conversation_id = conversation_id and cm.user_id = auth.uid()));

create policy packing_video_participant_read on public.packing_videos for select using (seller_id = auth.uid() or exists (select 1 from public.orders o where o.id = order_id and o.buyer_id = auth.uid()));
create policy reviews_public_read on public.reviews for select using (true);
create policy reviews_participant_insert on public.reviews for insert with check (reviewer_id = auth.uid() and exists (select 1 from public.orders o where o.id = order_id and (o.buyer_id = auth.uid() or o.seller_id = auth.uid()) and o.status = 'completed'));
create policy notifications_self on public.notifications for all using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy subscriptions_self_read on public.subscriptions for select using (user_id = auth.uid());
create policy authenticity_public_read on public.authenticity_checks for select using (exists (select 1 from public.listings l where l.id = listing_id and (l.status = 'active' or l.seller_id = auth.uid())));
create policy showcases_public_read on public.showcases for select using (ends_at > now());
create policy disputes_participant_read on public.disputes for select using (opened_by = auth.uid() or exists (select 1 from public.orders o where o.id = order_id and (o.buyer_id = auth.uid() or o.seller_id = auth.uid())));
create policy reports_self_read on public.reports for select using (reporter_id = auth.uid());
create policy reports_self_insert on public.reports for insert with check (reporter_id = auth.uid());

-- NOTE: auction price/decrement, order creation, payment transitions, shipping quotes,
-- seller verification, showcase entitlement and dispute resolution must be performed by
-- trusted Edge Functions/service-role code. Do not expose service-role credentials to Flutter.
