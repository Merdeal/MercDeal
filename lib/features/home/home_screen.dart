import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
import '../../models/listing.dart';
import '../deal_plus/deal_plus_screen.dart';
import '../how_it_works/how_it_works_screen.dart';
import '../listing/listing_detail_screen.dart';
import '../notifications/notifications_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ambient;
  Timer? _feedTimer;
  int _feedIndex = 0;

  final products = const <Listing>[
    Listing(id: '1', title: 'iPhone 14 Pro 128GB', category: 'Elettronica', priceLabel: '€599,00', oldPriceLabel: '€999,00', dropLabel: '-40%', asset: 'phone.png', location: 'Viterbo', price: 599, startPrice: 999, minimumPrice: 550, drop: 5, mode: SaleMode.descendingAuction, condition: ListingCondition.likeNew, verifiedSeller: true, showcase: false, followers: 124, offers: 18),
    Listing(id: '2', title: 'Samsung Galaxy Watch 6', category: 'Elettronica', priceLabel: '€224,00', oldPriceLabel: '€299,00', dropLabel: '-25%', asset: 'watch.png', location: 'Roma', price: 224, startPrice: 299, minimumPrice: 210, drop: 2, mode: SaleMode.descendingAuction, condition: ListingCondition.excellent, verifiedSeller: true, showcase: true, followers: 87, offers: 11),
    Listing(id: '3', title: 'Nike Air Force', category: 'Moda', priceLabel: '€84,00', oldPriceLabel: '€120,00', dropLabel: '-30%', asset: 'sneaker.png', location: 'Milano', price: 84, startPrice: 120, minimumPrice: 70, drop: 1, mode: SaleMode.descendingAuction, condition: ListingCondition.likeNew, verifiedSeller: true, showcase: false, followers: 56, offers: 7),
    Listing(id: '4', title: 'PlayStation 5', category: 'Gaming', priceLabel: '€310,00', oldPriceLabel: '€499,00', dropLabel: '-38%', asset: 'console.png', location: 'Torino', price: 310, startPrice: 499, minimumPrice: 290, drop: 3, mode: SaleMode.descendingAuction, condition: ListingCondition.good, verifiedSeller: true, showcase: false, followers: 102, offers: 12),
    Listing(id: '5', title: 'Action Cam 12', category: 'Fotografia', priceLabel: '€280,00', oldPriceLabel: '€399,00', dropLabel: '-30%', asset: 'camera.png', location: 'Bologna', price: 280, startPrice: 399, minimumPrice: 250, drop: 4, mode: SaleMode.descendingAuction, condition: ListingCondition.likeNew, verifiedSeller: true, showcase: true, followers: 74, offers: 8),
    Listing(id: '6', title: 'Auricolari Premium', category: 'Musica', priceLabel: '€98,00', oldPriceLabel: '€279,00', dropLabel: '-65%', asset: 'earbuds.png', location: 'Napoli', price: 98, startPrice: 279, minimumPrice: 90, drop: 2, mode: SaleMode.descendingAuction, condition: ListingCondition.likeNew, verifiedSeller: true, showcase: false, followers: 61, offers: 5),
  ];

  @override
  void initState() {
    super.initState();
    _ambient = AnimationController(vsync: this, duration: const Duration(seconds: 9))..repeat();
    _feedTimer = Timer.periodic(const Duration(minutes: 2), (_) => _rotateFeed());
  }

  void _rotateFeed() {
    if (mounted) setState(() => _feedIndex = (_feedIndex + 1) % products.length);
  }

  @override
  void dispose() {
    _feedTimer?.cancel();
    _ambient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rotated = [...products.skip(_feedIndex), ...products.take(_feedIndex)];
    return AnimatedBuilder(
      animation: _ambient,
      builder: (context, _) => SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
          children: [
            _Header(onNotifications: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()))),
            const SizedBox(height: 14),
            _Search(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()))),
            const SizedBox(height: 16),
            _Hero(progress: _ambient.value, onTap: _rotateFeed),
            const SizedBox(height: 18),
            _Categories(),
            const SizedBox(height: 20),
            _SectionTitle(title: '⚡ Sta scendendo ora', action: 'Vedi tutti'),
            const SizedBox(height: 9),
            _dealRow(context, rotated.take(4).toList()),
            const SizedBox(height: 20),
            _AuctionFeature(product: products[3], progress: _ambient.value, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ListingDetailScreen(listing: products[3])))),
            const SizedBox(height: 20),
            _SectionTitle(title: '🔥 Affari in discesa', action: 'Vedi tutti'),
            const SizedBox(height: 9),
            _dealRow(context, rotated.reversed.take(4).toList()),
            const SizedBox(height: 20),
            _DiscoverCard(onTap: _rotateFeed, index: _feedIndex),
            const SizedBox(height: 20),
            _SectionTitle(title: '💎 Vetrina Deal+', action: 'Vedi tutti', onAction: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DealPlusScreen()))),
            const SizedBox(height: 9),
            _dealRow(context, products.where((x) => x.showcase).toList()),
            const SizedBox(height: 20),
            _SafetyStrip(),
            const SizedBox(height: 20),
            GlassCard(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HowItWorksScreen())),
              glow: true,
              child: const Row(children: [Icon(Icons.auto_awesome_rounded, color: MercDealTheme.blue), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Come funziona MercDeal', style: TextStyle(fontWeight: FontWeight.w900)), SizedBox(height: 3), Text('Scopri aste, acquisti, spedizioni e ritiro a mano.', style: TextStyle(color: Colors.white54, fontSize: 11))])), Icon(Icons.chevron_right_rounded, color: MercDealTheme.green)]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dealRow(BuildContext context, List<Listing> list) => SizedBox(
        height: 274,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(width: 11),
          itemBuilder: (_, i) => TweenAnimationBuilder<double>(
            key: ValueKey('${list[i].id}$_feedIndex'),
            tween: Tween(begin: 0.96, end: 1),
            duration: const Duration(milliseconds: 520),
            curve: Curves.easeOutBack,
            builder: (_, scale, child) => Transform.scale(scale: scale, child: child),
            child: DealCard(
              title: list[i].title,
              price: list[i].priceLabel,
              oldPrice: list[i].oldPriceLabel,
              drop: list[i].dropLabel,
              asset: list[i].asset,
              category: list[i].category,
              showcase: list[i].showcase,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ListingDetailScreen(listing: list[i]))),
            ),
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header({required this.onNotifications});
  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) => Row(children: [
        Container(width: 44, height: 44, padding: const EdgeInsets.all(5), decoration: BoxDecoration(color: MercDealTheme.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: MercDealTheme.green.withValues(alpha: .48)), boxShadow: [BoxShadow(color: MercDealTheme.green.withValues(alpha: .12), blurRadius: 22)]), child: Image.asset('assets/icon/app_icon.png')),
        const SizedBox(width: 10),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text.rich(TextSpan(children: [TextSpan(text: 'Merc', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)), TextSpan(text: 'Deal', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, color: MercDealTheme.blue))])), Text('IL PREZZO SCENDE. L’AFFARE SALE.', style: TextStyle(color: Colors.white38, fontSize: 8, letterSpacing: .7, fontWeight: FontWeight.w800))])),
        Stack(children: [IconButton(onPressed: onNotifications, icon: const Icon(Icons.notifications_none_rounded, size: 27)), Positioned(right: 5, top: 2, child: Container(width: 17, height: 17, decoration: const BoxDecoration(color: Color(0xFFFF5C6C), shape: BoxShape.circle), alignment: Alignment.center, child: const Text('3', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900))))]),
        const SizedBox(width: 2),
        Container(width: 38, height: 38, decoration: BoxDecoration(shape: BoxShape.circle, gradient: const LinearGradient(colors: [MercDealTheme.green, MercDealTheme.blue]), boxShadow: [BoxShadow(color: MercDealTheme.green.withValues(alpha: .18), blurRadius: 18)]), padding: const EdgeInsets.all(2), child: const CircleAvatar(backgroundColor: MercDealTheme.card2, child: Icon(Icons.person_rounded, size: 21))),
      ]);
}

class _Search extends StatelessWidget {
  const _Search({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .035),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: MercDealTheme.blue.withValues(alpha: .55)),
              boxShadow: [BoxShadow(color: MercDealTheme.blue.withValues(alpha: .08), blurRadius: 26)],
            ),
            child: const Row(children: [Icon(Icons.search_rounded, color: Colors.white, size: 27), SizedBox(width: 12), Expanded(child: Text('Cerca il tuo prossimo affare...', style: TextStyle(color: Colors.white54, fontSize: 14))), Icon(Icons.qr_code_scanner_rounded, color: MercDealTheme.green, size: 24)]),
          ),
        ),
      );
}

class _Hero extends StatelessWidget {
  const _Hero({required this.progress, required this.onTap});
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final drift = math.sin(progress * math.pi * 2) * 5;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 205,
        padding: const EdgeInsets.fromLTRB(18, 18, 12, 15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(28), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF062F2A), Color(0xFF071C2C), Color(0xFF040C15)]), border: Border.all(color: MercDealTheme.green.withValues(alpha: .42)), boxShadow: [BoxShadow(color: MercDealTheme.green.withValues(alpha: .12), blurRadius: 35), BoxShadow(color: MercDealTheme.blue.withValues(alpha: .08), blurRadius: 55)]),
        child: Stack(children: [
          Positioned(right: -25, top: -30, child: Transform.rotate(angle: -.18, child: Icon(Icons.trending_down_rounded, size: 170, color: MercDealTheme.green.withValues(alpha: .12)))),
          Positioned(right: 15, bottom: 2, child: Transform.translate(offset: Offset(0, drift), child: Image.asset('assets/images/phone.png', width: 115, height: 125, fit: BoxFit.contain))),
          Positioned(right: 72, top: 28, child: Transform.translate(offset: Offset(0, -drift), child: Image.asset('assets/images/earbuds.png', width: 75, height: 75, fit: BoxFit.contain))),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('IL PREZZO SCENDE.', style: TextStyle(color: MercDealTheme.blue, fontSize: 18, fontWeight: FontWeight.w900)),
            const Text('L’AFFARE SALE.', style: TextStyle(color: MercDealTheme.green, fontSize: 24, fontWeight: FontWeight.w900, height: 1)),
            const SizedBox(height: 8),
            const SizedBox(width: 205, child: Text('Ogni giorno nuovi prodotti con prezzi sempre più bassi.', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.25))),
            const Spacer(),
            Material(color: Colors.transparent, child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18), child: Container(padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 11), decoration: BoxDecoration(color: MercDealTheme.green, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: MercDealTheme.green.withValues(alpha: .28), blurRadius: 22)]), child: const Row(mainAxisSize: MainAxisSize.min, children: [Text('SCOPRI GLI AFFARI', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12)), SizedBox(width: 7), Icon(Icons.arrow_forward_rounded, color: Colors.black, size: 18)])))),
          ]),
        ]),
      ),
    );
  }
}

class _Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const data = [
      (Icons.local_fire_department_rounded, 'Offerte'),
      (Icons.sell_rounded, 'Elettronica'),
      (Icons.checkroom_rounded, 'Moda'),
      (Icons.home_rounded, 'Casa'),
      (Icons.sports_esports_rounded, 'Gaming'),
      (Icons.grid_view_rounded, 'Tutte'),
    ];
    return SizedBox(
      height: 83,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        separatorBuilder: (_, __) => const SizedBox(width: 13),
        itemBuilder: (_, i) => SizedBox(width: 62, child: Column(children: [Container(width: 54, height: 54, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: .025), border: Border.all(color: (i == 0 ? MercDealTheme.green : MercDealTheme.blue).withValues(alpha: .35)), boxShadow: [BoxShadow(color: (i == 0 ? MercDealTheme.green : MercDealTheme.blue).withValues(alpha: .07), blurRadius: 18)]), child: Icon(data[i].$1, color: i == 0 ? MercDealTheme.green : MercDealTheme.blue, size: 24)), const SizedBox(height: 5), Text(data[i].$2, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800))])),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.action, this.onAction});
  final String title;
  final String action;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => Row(children: [Expanded(child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900))), TextButton(onPressed: onAction, child: Text(action, style: const TextStyle(color: MercDealTheme.blue, fontWeight: FontWeight.w900)))]);
}

class _AuctionFeature extends StatelessWidget {
  const _AuctionFeature({
    required this.product,
    required this.progress,
    required this.onTap,
  });

  final Listing product;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final pulse = 0.88 + math.sin(progress * math.pi * 2) * .08;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFF231E09), Color(0xFF101E1A), Color(0xFF07121C)],
          ),
          border: Border.all(color: MercDealTheme.gold.withValues(alpha: .52)),
          boxShadow: [
            BoxShadow(
              color: MercDealTheme.gold.withValues(alpha: .08),
              blurRadius: 30,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.workspace_premium_rounded,
                  color: MercDealTheme.gold,
                  size: 22,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'ASTA DEL GIORNO',
                    style: TextStyle(
                      color: MercDealTheme.gold,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Transform.scale(
                  scale: pulse,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .06),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 15,
                          color: Colors.white70,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '08:24:17',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: 126,
                    height: 126,
                    color: MercDealTheme.card,
                    child: Image.asset(
                      'assets/images/${product.asset}',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        '€499',
                        style: TextStyle(
                          color: Colors.white38,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 13,
                        ),
                      ),
                      const Text(
                        '€310',
                        style: TextStyle(
                          color: MercDealTheme.green,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Text(
                        '↓ €3 oggi',
                        style: TextStyle(
                          color: MercDealTheme.green,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MercDealTheme.gold.withValues(alpha: .55),
                              ),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: const Text(
                              'QUASI AL MINIMO',
                              style: TextStyle(
                                color: MercDealTheme.gold,
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              color: MercDealTheme.green,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  'SCOPRI',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscoverCard extends StatelessWidget {
  const _DiscoverCard({required this.onTap, required this.index});

  final VoidCallback onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.casino_rounded,
      Icons.auto_awesome_rounded,
      Icons.local_offer_rounded,
    ];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 128,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF072F34), Color(0xFF0A1230)],
          ),
          border: Border.all(color: MercDealTheme.blue.withValues(alpha: .5)),
          boxShadow: [
            BoxShadow(
              color: MercDealTheme.blue.withValues(alpha: .08),
              blurRadius: 30,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: .18),
                border: Border.all(
                  color: MercDealTheme.green.withValues(alpha: .35),
                ),
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 450),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                  child: Icon(
                    icons[index % icons.length],
                    key: ValueKey(index),
                    color: MercDealTheme.green,
                    size: 34,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'SCOPRI UN AFFARE',
                    style: TextStyle(
                      color: MercDealTheme.blue,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Un nuovo prodotto può sorprenderti ogni pochi minuti.',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                  const SizedBox(height: 9),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: MercDealTheme.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '🎲 SCOPRI ORA',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SafetyStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(children: const [Expanded(child: _SafetyItem(icon: Icons.verified_user_rounded, title: 'SICURO', text: 'Venditori verificati')), SizedBox(width: 9), Expanded(child: _SafetyItem(icon: Icons.local_shipping_rounded, title: 'SPEDIZIONI', text: 'Costi chiari')), SizedBox(width: 9), Expanded(child: _SafetyItem(icon: Icons.bolt_rounded, title: 'DINAMICO', text: 'Prezzi in discesa'))]);
}

class _SafetyItem extends StatelessWidget {
  const _SafetyItem({required this.icon, required this.title, required this.text});
  final IconData icon;
  final String title;
  final String text;
  @override
  Widget build(BuildContext context) => Container(height: 94, padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10), decoration: BoxDecoration(color: Colors.white.withValues(alpha: .025), borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.white.withValues(alpha: .08))), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: MercDealTheme.green, size: 21), const SizedBox(height: 5), Text(title, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900)), const SizedBox(height: 2), Text(text, textAlign: TextAlign.center, maxLines: 2, style: const TextStyle(color: Colors.white38, fontSize: 8))]));
}
