import 'dart:async';
import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
import '../../models/listing.dart';
import '../listing/listing_detail_screen.dart';
import '../notifications/notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  int discovery = 0;
  final products = const [
    Listing(id: '1', title: 'Sony Alpha 7 III', category: 'Fotografia', price: 1179.80, startPrice: 1240, minimumPrice: 1090, drop: .20, followers: 18, icon: Icons.camera_alt_rounded, mode: SaleMode.descendingAuction, condition: ListingCondition.excellent, verifiedSeller: true, inShowcase: true, location: 'Roma'),
    Listing(id: '2', title: 'PlayStation 5 Slim', category: 'Gaming', price: 454.80, startPrice: 520, minimumPrice: 420, drop: .20, followers: 34, icon: Icons.sports_esports_rounded, mode: SaleMode.descendingAuction, condition: ListingCondition.excellent, verifiedSeller: true, inShowcase: false, location: 'Milano'),
    Listing(id: '3', title: 'MacBook Air M2', category: 'Informatica', price: 749.40, startPrice: 890, minimumPrice: 690, drop: .20, followers: 27, icon: Icons.laptop_mac_rounded, mode: SaleMode.descendingAuction, condition: ListingCondition.good, verifiedSeller: true, inShowcase: true, location: 'Bologna'),
  ];

  @override
  void initState() { super.initState(); timer = Timer.periodic(const Duration(minutes: 2), (_) { if (mounted) setState(() => discovery = (discovery + 1) % products.length); }); }
  @override
  void dispose() { timer?.cancel(); super.dispose(); }

  void openListing(Listing listing) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ListingDetailScreen(listing: listing)));

  @override
  Widget build(BuildContext context) {
    final p = products[discovery];
    return SafeArea(child: CustomScrollView(slivers: [
      SliverPadding(padding: const EdgeInsets.fromLTRB(18, 18, 18, 0), sliver: SliverToBoxAdapter(child: Row(children: [Container(width: 43, height: 43, decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), gradient: const LinearGradient(colors: [MercDealTheme.green, MercDealTheme.blue])), child: const Icon(Icons.local_offer_rounded, color: Color(0xFF06110D))), const SizedBox(width: 11), const Text('MercDeal', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)), const Spacer(), IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen())), icon: const Icon(Icons.notifications_none_rounded))]))),
      SliverPadding(padding: const EdgeInsets.fromLTRB(18, 18, 18, 0), sliver: SliverToBoxAdapter(child: Container(height: 54, padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: MercDealTheme.card, borderRadius: BorderRadius.circular(19), border: Border.all(color: Colors.white.withValues(alpha: .07))), child: const Row(children: [Icon(Icons.search_rounded, color: Colors.white54), SizedBox(width: 10), Expanded(child: Text('Cerca il tuo prossimo affare...', style: TextStyle(color: Colors.white38))), Icon(Icons.mic_none_rounded, color: MercDealTheme.green)])))),
      SliverPadding(padding: const EdgeInsets.fromLTRB(18, 18, 18, 0), sliver: SliverToBoxAdapter(child: _hero(context))),
      SliverPadding(padding: const EdgeInsets.fromLTRB(18, 22, 18, 0), sliver: SliverToBoxAdapter(child: const SectionHeader(title: '✨ Scopri ora', action: '🎲 Affare casuale'))),
      SliverPadding(padding: const EdgeInsets.fromLTRB(18, 10, 18, 0), sliver: SliverToBoxAdapter(child: DealCard(title: p.title, price: '€${p.price.toStringAsFixed(2).replaceAll('.', ',')}', subtitle: '−€0,20 oggi · ${p.followers} seguono', icon: p.icon, featured: p.inShowcase, onTap: () => openListing(p)))),
      SliverPadding(padding: const EdgeInsets.fromLTRB(18, 24, 18, 0), sliver: SliverToBoxAdapter(child: const SectionHeader(title: '📉 Sta scendendo ora', action: 'Vedi tutto'))),
      SliverToBoxAdapter(child: SizedBox(height: 260, child: ListView.separated(padding: const EdgeInsets.fromLTRB(18, 10, 18, 0), scrollDirection: Axis.horizontal, itemCount: products.length, separatorBuilder: (_, __) => const SizedBox(width: 12), itemBuilder: (_, i) { final x = products[i]; return DealCard(title: x.title, price: '€${x.price.toStringAsFixed(2).replaceAll('.', ',')}', subtitle: '−€0,20 · ${x.category}', icon: x.icon, featured: x.inShowcase, onTap: () => openListing(x)); }))),
      SliverPadding(padding: const EdgeInsets.fromLTRB(18, 24, 18, 0), sliver: SliverToBoxAdapter(child: const SectionHeader(title: '🔥 Quasi al tuo prezzo'))),
      SliverPadding(padding: const EdgeInsets.fromLTRB(18, 10, 18, 0), sliver: SliverToBoxAdapter(child: _targetCard(products[1]))),
      SliverPadding(padding: const EdgeInsets.fromLTRB(18, 24, 18, 0), sliver: SliverToBoxAdapter(child: const SectionHeader(title: 'Categorie'))),
      SliverPadding(padding: const EdgeInsets.fromLTRB(18, 10, 18, 0), sliver: SliverToBoxAdapter(child: _categories())),
      SliverPadding(padding: const EdgeInsets.fromLTRB(18, 24, 18, 30), sliver: SliverToBoxAdapter(child: _howItWorks(context))),
    ]));
  }

  Widget _hero(BuildContext context) => Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(borderRadius: BorderRadius.circular(27), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF102D3C), Color(0xFF07111F)]), border: Border.all(color: MercDealTheme.green.withValues(alpha: .18))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('IL PREZZO SCENDE.', style: TextStyle(fontSize: 12, color: MercDealTheme.green, fontWeight: FontWeight.w900, letterSpacing: 1.4)), const SizedBox(height: 4), const Text('L’AFFARE SALE.', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)), const SizedBox(height: 8), const Text('Scopri prodotti, segui il prezzo e compra quando trovi il momento giusto.', style: TextStyle(color: Colors.white60, height: 1.35)), const SizedBox(height: 16), Row(children: [Expanded(child: GlowButton(label: 'Scopri gli affari', icon: Icons.arrow_forward_rounded, onPressed: () {})), const SizedBox(width: 10), IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border))]) ]));

  Widget _targetCard(Listing x) => Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: MercDealTheme.card, borderRadius: BorderRadius.circular(22), border: Border.all(color: Colors.white.withValues(alpha: .07))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Container(width: 48, height: 48, decoration: BoxDecoration(color: Colors.white.withValues(alpha: .04), borderRadius: BorderRadius.circular(14)), child: Icon(x.icon, color: MercDealTheme.blue)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(x.title, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 3), Text('Obiettivo €450,00 · ora €${x.price.toStringAsFixed(2).replaceAll('.', ',')}', style: const TextStyle(color: Colors.white54, fontSize: 12))])), const Icon(Icons.notifications_active_outlined, color: MercDealTheme.green)]), const SizedBox(height: 14), ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: .74, minHeight: 7, backgroundColor: Colors.white10, color: MercDealTheme.green)), const SizedBox(height: 8), const Text('Sei vicino al tuo prezzo obiettivo', style: TextStyle(color: MercDealTheme.green, fontSize: 12, fontWeight: FontWeight.w700))]));

  Widget _categories() { final cats = [('Elettronica', Icons.devices_rounded), ('Gaming', Icons.sports_esports_rounded), ('Moda', Icons.checkroom_rounded), ('Casa', Icons.chair_rounded), ('Auto & Moto', Icons.directions_car_rounded), ('Fotografia', Icons.camera_alt_rounded), ('Sport', Icons.sports_soccer_rounded), ('Collezionismo', Icons.auto_awesome_rounded)]; return Wrap(spacing: 10, runSpacing: 10, children: cats.map((c) => Container(width: 106, padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8), decoration: BoxDecoration(color: MercDealTheme.card, borderRadius: BorderRadius.circular(17), border: Border.all(color: Colors.white.withValues(alpha: .05))), child: Column(children: [Icon(c.$2, color: MercDealTheme.blue), const SizedBox(height: 7), Text(c.$1, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700))]))).toList()); }

  Widget _howItWorks(BuildContext context) => Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: const Color(0xFF0A1724), borderRadius: BorderRadius.circular(23)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Come funziona?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)), const SizedBox(height: 8), const Text('Il marketplace dove non devi indovinare quando comprare: segui il prezzo e decidi tu.', style: TextStyle(color: Colors.white54, height: 1.4)), const SizedBox(height: 14), Row(children: [Expanded(child: _step('1', 'Segui', 'Trova un affare')), Expanded(child: _step('2', 'Aspetta', 'Il prezzo scende')), Expanded(child: _step('3', 'Compra', 'Quando vuoi'))]), const SizedBox(height: 15), GlowButton(label: 'Scopri MercDeal', secondary: true, onPressed: () {})]));
  Widget _step(String n, String t, String s) => Column(children: [Container(width: 34, height: 34, alignment: Alignment.center, decoration: const BoxDecoration(color: MercDealTheme.green, shape: BoxShape.circle), child: Text(n, style: const TextStyle(color: Color(0xFF04120B), fontWeight: FontWeight.w900))), const SizedBox(height: 7), Text(t, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 2), Text(s, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white38, fontSize: 10))]);
}
