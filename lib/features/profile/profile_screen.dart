import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
import '../orders/orders_screen.dart';
import '../reviews/reviews_screen.dart';
import '../auth/auth_screen.dart';
import '../notifications/notifications_screen.dart';
import '../deal_plus/deal_plus_screen.dart';
import '../how_it_works/how_it_works_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(18, 18, 18, 30), children: [
    Row(children: [
      Container(width: 64, height: 64, decoration: BoxDecoration(shape: BoxShape.circle, gradient: const LinearGradient(colors: [MercDealTheme.green, MercDealTheme.blue])), child: const Icon(Icons.person_rounded, color: Color(0xFF04120B), size: 34)),
      const SizedBox(width: 13),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Il tuo profilo', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)), SizedBox(height: 4), Text('Scopri la tua reputazione MercDeal', style: TextStyle(color: Colors.white54))])),
      IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())), icon: const Icon(Icons.notifications_none_rounded)),
    ]),
    const SizedBox(height: 18),
    Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: MercDealTheme.card, borderRadius: BorderRadius.circular(22), border: Border.all(color: MercDealTheme.green.withValues(alpha: .15))), child: const Row(children: [Icon(Icons.verified_rounded, color: MercDealTheme.green, size: 30), SizedBox(width: 11), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Venditore verificato', style: TextStyle(fontWeight: FontWeight.w900)), SizedBox(height: 3), Text('Completa la verifica prima di pubblicare.', style: TextStyle(color: Colors.white54, fontSize: 12))])), Icon(Icons.chevron_right_rounded, color: const Color(0x61FFFFFF))])),
    const SizedBox(height: 14),
    _Tile(icon: Icons.shopping_bag_outlined, title: 'I miei ordini', subtitle: 'Acquisti, spedizioni e ritiri', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrdersScreen()))),
    _Tile(icon: Icons.star_outline_rounded, title: 'Le mie recensioni', subtitle: 'Reputazione e feedback reali', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReviewsScreen()))),
    _Tile(icon: Icons.diamond_outlined, title: 'Deal+', subtitle: 'Monitoraggio avanzato e Vetrina', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DealPlusScreen()))),
    _Tile(icon: Icons.menu_book_outlined, title: 'Come funziona MercDeal', subtitle: 'Guida per venditori e acquirenti', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HowItWorksScreen()))),
    const SizedBox(height: 12),
    GlowButton(label: 'Accedi / Registrati', icon: Icons.login_rounded, secondary: true, onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AuthScreen()))),
  ]));
}

class _Tile extends StatelessWidget {
  final IconData icon; final String title, subtitle; final VoidCallback onTap;
  const _Tile({required this.icon, required this.title, required this.subtitle, required this.onTap});
  @override Widget build(BuildContext context) => Container(margin: const EdgeInsets.only(bottom: 9), decoration: BoxDecoration(color: MercDealTheme.card, borderRadius: BorderRadius.circular(18)), child: ListTile(onTap: onTap, leading: Container(width: 44, height: 44, decoration: BoxDecoration(color: MercDealTheme.green.withValues(alpha: .08), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: MercDealTheme.green)), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)), subtitle: Text(subtitle, style: const TextStyle(color: const Color(0x73FFFFFF), fontSize: 12)), trailing: const Icon(Icons.chevron_right_rounded, color: const Color(0x61FFFFFF))));
}
