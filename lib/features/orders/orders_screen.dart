import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
import '../shipping/shipping_screen.dart';
import '../meetup/meetup_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('I miei ordini', style: TextStyle(fontWeight: FontWeight.w900))),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      _OrderCard(title: 'Sony Alpha 7 III', price: '€720,00', status: 'In preparazione', icon: Icons.camera_alt_outlined, color: MercDealTheme.green, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ShippingScreen()))),
      _OrderCard(title: 'Nintendo Switch OLED', price: '€240,00', status: 'Ritiro programmato', icon: Icons.sports_esports_outlined, color: MercDealTheme.blue, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MeetupScreen()))),
      const SizedBox(height: 18),
      const EmptyState(icon: Icons.verified_outlined, title: 'Ogni affare lascia una traccia', text: 'Quando un ordine viene concluso, qui trovi stato, sicurezza, consegna e recensione.'),
    ]),
  );
}
class _OrderCard extends StatelessWidget {
  final String title, price, status; final IconData icon; final Color color; final VoidCallback onTap;
  const _OrderCard({required this.title, required this.price, required this.status, required this.icon, required this.color, required this.onTap});
  @override Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(22), child: Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: MercDealTheme.card, borderRadius: BorderRadius.circular(22), border: Border.all(color: Colors.white.withValues(alpha: .06))), child: Row(children: [Container(width: 62, height: 62, decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), color: color.withValues(alpha: .09)), child: Icon(icon, color: color, size: 30)), const SizedBox(width: 13), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w900)), const SizedBox(height: 5), Text(price, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)), const SizedBox(height: 4), Text(status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800))])), const Icon(Icons.chevron_right_rounded, color: Colors.white38)])));
}
