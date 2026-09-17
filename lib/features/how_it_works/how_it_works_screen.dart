import 'package:flutter/material.dart';
import '../../app/theme.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Come funziona MercDeal', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 30),
        children: [
          const Text('Scegli il tuo percorso', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
          const SizedBox(height: 15),
          _Flow(Icons.storefront_outlined, 'SONO UN VENDITORE', const [
            'Crea il tuo annuncio',
            'Scegli Compralo subito, Asta al ribasso o Proposta libera',
            'Inserisci peso e dimensioni se spedisci',
            'Completa la verifica venditore',
            'Quando vendi: pagamento, etichetta e video imballaggio',
            'A consegna conclusa lasciate entrambi una recensione',
          ]),
          const SizedBox(height: 14),
          _Flow(Icons.shopping_bag_outlined, 'SONO UN ACQUIRENTE', const [
            'Scopri gli affari',
            'Segui un prodotto e imposta il tuo prezzo obiettivo',
            'Guarda il prezzo scendere di €0,20 al giorno',
            'Fai un’offerta oppure compra subito',
            'Vedi il costo reale della spedizione prima di confermare',
            'Ricevi, controlla e conferma la ricezione',
            'Lascia la recensione',
          ]),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: MercDealTheme.card, borderRadius: BorderRadius.circular(22)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('📉 L’asta al ribasso', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                SizedBox(height: 10),
                Text('€80,00', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                Text('↓ €79,80', style: TextStyle(color: MercDealTheme.green, fontWeight: FontWeight.w800)),
                Text('↓ €79,60', style: TextStyle(color: MercDealTheme.green, fontWeight: FontWeight.w800)),
                Text('↓ …', style: TextStyle(color: Colors.white38, fontWeight: FontWeight.w800)),
                Text('€65,00 · Prezzo minimo raggiunto', style: TextStyle(color: MercDealTheme.blue, fontWeight: FontWeight.w800)),
                SizedBox(height: 8),
                Text('Il minimo del venditore resta nascosto e il prezzo non scende oltre quella soglia.', style: TextStyle(color: Colors.white45, height: 1.35)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Flow extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> steps;

  const _Flow(this.icon, this.title, this.steps);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: MercDealTheme.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: .06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Icon(icon, color: MercDealTheme.green), const SizedBox(width: 9), Text(title, style: const TextStyle(fontWeight: FontWeight.w900))]),
          const SizedBox(height: 12),
          ...steps.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: MercDealTheme.green, shape: BoxShape.circle),
                    child: Text('${entry.key + 1}', style: const TextStyle(color: Color(0xFF04120B), fontSize: 11, fontWeight: FontWeight.w900)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(entry.value, style: const TextStyle(color: Colors.white70, height: 1.25))),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
