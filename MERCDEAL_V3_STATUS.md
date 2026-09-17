# MercDeal V3 — Complete final source package

MercDeal is a dark/glossy marketplace experience centered on the downward-price auction.

## Included UX/product flows
- Premium dark/glossy neon green + blue visual system
- Branded splash and navigation: Home, Cerca, Vendi, Messaggi, Profilo
- Dynamic discovery Home: Scopri ora, Sta scendendo ora, Quasi al tuo prezzo, Vetrina Deal+
- Downward auction: €0.20/day, seller minimum hidden, 7/15/30 days
- Buy now and free offer flows
- Listing detail with follow/target-price concepts
- Shipping cost shown before purchase/offer; CAP, weight and dimensions UI
- Checkout, protected-payment messaging, shipping/tracking flow
- Hand pickup flow, seller-selected meeting point, temporary location consent, arrival state and 10-minute final window
- Seller verification and private verification-data concept
- Deal+ €4.99/month or €39.99/year; Vetrina for 7 days, one listing at a time
- MercDeal Authenticity states and evidence concepts
- Packing video (max 1 minute) and printable Security Seal concept
- Orders, confirmation/problem path and reviews
- Messages/chat restrictions concept
- Notifications and saved-price monitoring concepts
- MercDeal Report / safety flow
- How MercDeal works: buyer/seller timelines
- Supabase schema/security foundations
- Codemagic Android debug/release and iOS workflows

## Production integrations
Real payments, KYC/KYB, carrier pricing/labels, maps, push notifications and webhooks require production provider accounts, credentials, legal/compliance configuration and server-side implementation. The UI does not pretend those external services are live.

## Verification
The package has been structurally checked in this environment. Flutter SDK is not installed here, so Flutter analyze/test/build are not claimed as passed; Codemagic is the CI verification step.
