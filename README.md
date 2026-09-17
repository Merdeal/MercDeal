# MercDeal

MercDeal è un marketplace mobile progettato intorno a una modalità distintiva: **Asta al ribasso**. Il prezzo pubblico può scendere di €0,20 al giorno, mentre il prezzo minimo del venditore resta privato e viene applicato lato server.

## Funzioni incluse nel progetto

- Home discovery dinamica
- Ricerca e categorie
- Pubblicazione annuncio
- Compralo subito / Asta al ribasso / Proposta libera
- Preferiti e affari seguiti
- Auth UI e profilo
- Ordini
- Spedizione e tracking flow UI
- Ritiro a mano e posizione temporanea flow UI
- Chat e notifiche UI
- Recensioni
- Deal+ e Vetrina
- MercDeal Authenticity
- Video imballaggio
- Security Seal
- MercDeal Report
- Schema PostgreSQL + RLS + funzioni server per asta/offerte
- Icona MercDeal
- Configurazione Codemagic

## Regole prodotto

- Asta al ribasso: durata 7/15/30 giorni.
- Decremento automatico: €0,20 al giorno.
- Il prezzo minimo del venditore resta nascosto.
- Il prezzo non scende sotto il minimo.
- Il costo di spedizione deve essere mostrato prima di acquisto/offerta.
- Il venditore può offrire spedizione, ritiro a mano o entrambi.
- Per il ritiro a mano, il punto d'incontro viene definito dal venditore dopo l'acquisto.
- La posizione live è temporanea e richiede consenso esplicito.
- Deal+ è previsto a €4,99/mese o €39,99/anno; la Vetrina dura 7 giorni.

## Architettura

```text
Flutter App
   ↓
Supabase Auth
   ↓
PostgreSQL + RLS
   ↓
Storage / Realtime
   ↓
Edge Functions
   ↓
Pagamenti marketplace / spedizioni / notifiche / mappe
```

Il client non deve essere l'autorità per aste, offerte, ordini, pagamenti o diritti Deal+. La logica business-critical deve essere eseguita tramite codice trusted lato server.

## Supabase

- `supabase/schema.sql` contiene il modello dati.
- `supabase/migrations/002_marketplace_security.sql` contiene trigger e funzioni server-authoritative per profilo, prezzo asta e offerte.
- `SUPABASE_URL` e `SUPABASE_ANON_KEY` sono previste come variabili di build; nessun service-role key deve essere inserito nel client.

## Provider esterni

Pagamenti marketplace, KYC/KYB, preventivi spedizione, etichette, tracking, mappe e notifiche richiedono account, credenziali, webhook e configurazione di produzione. Il progetto contiene il flusso e i punti di integrazione, ma **non simula un pagamento reale né una spedizione reale**.

## Verifica build

In questo ambiente non è disponibile l'SDK Flutter, quindi non viene dichiarato un `flutter analyze`, `flutter test` o `flutter build apk` superato localmente. Codemagic esegue questi controlli nel workflow.

Prima della pubblicazione:

1. configurare Supabase;
2. applicare schema e migrazioni;
3. collegare provider pagamento/spedizione;
4. configurare webhook e segreti nelle Edge Functions;
5. configurare signing Android/iOS;
6. eseguire `flutter analyze`, `flutter test` e build release in CI;
7. completare privacy, termini, KYC e requisiti store.


## V3 final source package
This package contains the consolidated V3 UI, product flows, Supabase foundations, asset directories and Codemagic configuration. External production providers require their own credentials and webhook configuration.

## MercDeal V3 final
This package is the consolidated V3 source project. Android Debug is configured to run widget tests and build the APK; release/iOS keep static analysis with non-fatal infos/warnings. External production services require their own credentials and webhook configuration.

## MercDeal V3 complete package
This is the consolidated V3 source package. It includes the redesigned marketplace UI and the agreed buyer, seller, auction, shipping, pickup, safety, Deal+ and reputation flows. External providers require real production configuration.
