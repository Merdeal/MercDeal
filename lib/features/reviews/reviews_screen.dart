import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recensioni', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const GlassCard(glow: true, child: Row(children: [
          Icon(Icons.star_rounded, color: MercDealTheme.gold, size: 42),
          SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Reputazione reale', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            Text('Le valutazioni arrivano dalle transazioni concluse.', style: TextStyle(color: Colors.white54, fontSize: 11)),
          ])),
        ])),
        const SizedBox(height: 12),
        _review('MarcoP', '★★★★★', 'Tutto perfetto. Comunicazione rapida.'),
        _review('Giulia87', '★★★★★', 'Prodotto conforme e spedizione veloce.'),
        _review('AleTech', '★★★★☆', 'Ottima comunicazione.'),
        const SizedBox(height: 12),
        const Text('Una recensione per parte, dopo ogni affare concluso.', style: TextStyle(color: Colors.white54, fontSize: 11)),
      ]),
    );
  }
  Widget _review(String name, String stars, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [const CircleAvatar(radius: 17, child: Icon(Icons.person_rounded, size: 18)), const SizedBox(width: 8), Text(name, style: const TextStyle(fontWeight: FontWeight.w900)), const Spacer(), Text(stars, style: const TextStyle(color: MercDealTheme.gold))]),
      const SizedBox(height: 7),
      Text(text, style: const TextStyle(color: Colors.white70, fontSize: 11)),
    ])),
  );
}
