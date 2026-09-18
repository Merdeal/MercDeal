import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
import '../shipping/shipping_screen.dart';
import '../meetup/meetup_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('I miei ordini', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Ordini e vendite', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          _order(context, 'iPhone 14 Pro 128GB', '€599,00', 'Spedizione · In preparazione', Icons.local_shipping_outlined,
              () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShippingScreen()))),
          _order(context, 'Samsung Galaxy Watch 6', '€224,00', 'Ritiro a mano · Programmato', Icons.location_on_outlined,
              () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MeetupScreen()))),
          _order(context, 'PlayStation 5', '€310,00', 'Asta · 12 offerte', Icons.gavel_rounded, () {}),
          const SizedBox(height: 10),
          const Text('Dopo una transazione completata, entrambe le parti devono lasciare una recensione.',
              style: TextStyle(color: Colors.white54, fontSize: 11)),
        ],
      ),
    );
  }
  Widget _order(BuildContext context, String title, String price, String status, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: GlassCard(
        glow: true,
        onTap: onTap,
        child: Row(
          children: [
            Container(width: 60, height: 60, decoration: BoxDecoration(color: MercDealTheme.card2, borderRadius: BorderRadius.circular(16)), child: Icon(icon, color: MercDealTheme.green, size: 30)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
              Text(price, style: const TextStyle(color: MercDealTheme.green, fontSize: 18, fontWeight: FontWeight.w900)),
              Text(status, style: const TextStyle(color: Colors.white54, fontSize: 10)),
            ])),
            const Icon(Icons.chevron_right_rounded, color: Colors.white30),
          ],
        ),
      ),
    );
  }
}
