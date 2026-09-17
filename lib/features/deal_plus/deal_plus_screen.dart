import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';

class DealPlusScreen extends StatelessWidget {
  const DealPlusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deal+', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              gradient: const LinearGradient(colors: [Color(0xFF153C37), Color(0xFF0A1724)]),
              border: Border.all(color: MercDealTheme.green.withValues(alpha: .22)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('💎 DEAL+', style: TextStyle(color: MercDealTheme.green, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                SizedBox(height: 7),
                Text('Segui l’affare\nsenza perderlo.', style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900)),
                SizedBox(height: 9),
                Text('Più controllo sul prezzo. Più strumenti per trovare il momento giusto.', style: TextStyle(color: Colors.white60, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _Benefit(Icons.notifications_active_outlined, 'Alert prezzo', 'Imposta una soglia e ricevi una notifica quando viene raggiunta.'),
          const _Benefit(Icons.tune_rounded, 'Filtri avanzati', 'Scopri per percentuale di ribasso, distanza, fine asta e altro.'),
          const _Benefit(Icons.show_chart_rounded, 'Storico prezzo', 'Visualizza l’andamento del prezzo degli affari seguiti.'),
          const _Benefit(Icons.diamond_outlined, 'Vetrina Premium', 'Metti una tua inserzione in Vetrina per 7 giorni.'),
          const SizedBox(height: 18),
          GlowButton(label: '€4,99 / mese', icon: Icons.arrow_forward_rounded, onPressed: () {}),
          const SizedBox(height: 9),
          GlowButton(label: '€39,99 / anno', secondary: true, onPressed: () {}),
          const SizedBox(height: 12),
          const Text('Abbonamento gestito dallo store. Prezzi e disponibilità possono variare in base al mercato.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white30, fontSize: 10)),
        ],
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _Benefit(this.icon, this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Icon(icon, color: MercDealTheme.green),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
      subtitle: Text(description, style: const TextStyle(color: const Color(0x73FFFFFF), fontSize: 12, height: 1.3)),
    );
  }
}
