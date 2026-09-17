# MercDeal Supabase

`schema.sql` is the database foundation for the MercDeal backend.

Critical business operations must be server-authoritative:
- auction daily decrement and minimum price
- offer acceptance/counteroffer
- order creation and immutable terms snapshot
- payment state transitions
- shipping quotes/labels/tracking webhooks
- seller KYC/verification state
- Deal+ subscription state and Vetrina entitlement
- dispute resolution

Secrets and provider credentials must live in Supabase Edge Function secrets, never in Flutter.
