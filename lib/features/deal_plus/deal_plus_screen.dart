import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';

class DealPlusScreen extends StatelessWidget {
  const DealPlusScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deal+', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(padding: const EdgeInsets.fromLTRB(16, 8, 16, 30), children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(28), gradient: const LinearGradient(colors: [Color(0xFF3C2C06), Color(0xFF17110A)]), border: Border.all(color: MercDealTheme.gold.withValues(alpha: .5)), boxShadow: const [BoxShadow(color: Color(0x33FFD45A), blurRadius: 30)]),
          child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(Icons.workspace_premium_rounded, color: MercDealTheme.gold, size: 44),
            SizedBox(height: 8),
            Text('Più vantaggi. Più affari.', style: TextStyle(color: MercDealTheme.gold, fontSize: 27, fontWeight: FontWeight.w900)),
            Text('Deal+ trasforma il monitoraggio in un’esperienza avanzata.', style: TextStyle(color: Colors.white70)),
          ]),
        ),
        const SizedBox(height: 14),
        const Text('€4,99 / mese', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
        const Text('oppure €39,99 / anno', style: TextStyle(color: Colors.white54)),
        const SizedBox(height: 14),
        ...['Monitoraggio prezzi avanzato','Soglia prezzo personalizzata','Filtri avanzati','Cronologia dei ribassi','Avvisi intelligenti','Esperienza senza pubblicità se introdurremo ads','Strumenti avanzati di scoperta'].map(_benefit),
        const SizedBox(height: 8),
        GlassCard(glow: true, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('💎 Vetrina Premium', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
          const SizedBox(height: 5),
          const Text('Ogni categoria ha la propria Vetrina. Con Deal+ puoi mettere 1 tuo annuncio alla volta in Vetrina per 7 giorni con badge “DEAL+ · IN VETRINA”.', style: TextStyle(color: Colors.white60, fontSize: 12, height: 1.4)),
          const SizedBox(height: 12),
          GlowButton(label: 'Metti un annuncio in Vetrina', icon: Icons.auto_awesome, onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Demo: selezione annuncio disponibile nel flusso venditore.')))),
        ])),
        const SizedBox(height: 12),
        GlowButton(label: 'Scopri Deal+', icon: Icons.workspace_premium_rounded, onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Demo: il checkout dell’abbonamento sarà collegato al provider in produzione.')))),
      ]),
    );
  }
  Widget _benefit(String text) => Padding(padding: const EdgeInsets.only(bottom: 7), child: Row(children: [const Icon(Icons.check_circle_rounded, color: MercDealTheme.green, size: 20), const SizedBox(width: 8), Expanded(child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)))]));
}
