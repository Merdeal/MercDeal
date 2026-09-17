# MercDeal V3 — Final Source Package

MercDeal is a dark/glossy marketplace centered on Asta al ribasso.

## Included product flows
- Dynamic discovery Home
- Search, categories, filters and saved searches UI
- Compralo subito / Asta al ribasso / Proposta libera
- €0.20/day downward auction rule, 7/15/30 days, hidden seller minimum
- Favorites and target-price monitoring UI
- Seller verification UI
- Deal+ €4.99/month / €39.99/year
- Vetrina Premium, 7 days, one listing at a time
- Checkout with shipping cost shown before purchase/offer
- Shipping/tracking UI
- Hand pickup appointment UI and temporary location consent
- Orders and delivery confirmation UI
- Reviews
- Chat and notifications UI
- MercDeal Authenticity UI
- Packing video / Security Seal UI
- MercDeal Report / safety UI
- Supabase schema/RLS/server-authoritative auction foundations
- Codemagic Android debug/release and iOS workflows

## Production integrations
Payments, KYC/KYB, shipping carrier accounts, maps, push notifications and webhooks remain configuration/integration steps requiring real provider accounts and secrets. No fake live payment or shipping transaction is represented as real.

## Verification
Flutter SDK is not available in this environment, so local Flutter analyze/test/build cannot be claimed as passed. Codemagic remains the authoritative CI verification step.
