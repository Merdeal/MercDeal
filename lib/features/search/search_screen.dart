import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../models/listing.dart';
import '../listing/listing_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  String selected = 'Consigliati';

  final listings = const [
    Listing(
      id: 's1', title: 'iPhone 15 Pro 256GB', category: 'Elettronica',
      price: 699.80, startPrice: 780, minimumPrice: 650, drop: .20,
      followers: 42, icon: Icons.phone_iphone_rounded,
      mode: SaleMode.descendingAuction, condition: ListingCondition.excellent,
      verifiedSeller: true, inShowcase: true, location: 'Roma',
    ),
    Listing(
      id: 's2', title: 'Nintendo Switch OLED', category: 'Gaming',
      price: 279.60, startPrice: 330, minimumPrice: 250, drop: .20,
      followers: 21, icon: Icons.sports_esports_rounded,
      mode: SaleMode.descendingAuction, condition: ListingCondition.good,
      verifiedSeller: true, inShowcase: false, location: 'Napoli',
    ),
    Listing(
      id: 's3', title: 'Nike Dunk Low', category: 'Moda',
      price: 109.40, startPrice: 150, minimumPrice: 95, drop: .20,
      followers: 15, icon: Icons.shopping_bag_rounded,
      mode: SaleMode.offer, condition: ListingCondition.newItem,
      verifiedSeller: true, inShowcase: false, location: 'Milano',
    ),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
            sliver: SliverToBoxAdapter(
              child: Text('Cerca', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
            sliver: SliverToBoxAdapter(child: _searchBar()),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
            sliver: SliverToBoxAdapter(child: _chips()),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  const Expanded(child: Text('Filtri avanzati', style: TextStyle(fontWeight: FontWeight.w900))),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.tune_rounded)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 4, 18, 30),
            sliver: SliverList.builder(
              itemCount: listings.length,
              itemBuilder: (context, index) => _listingTile(context, listings[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(color: MercDealTheme.card, borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.white54),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(fontWeight: FontWeight.w700),
              decoration: const InputDecoration(
                hintText: 'Cerca il tuo prossimo affare...',
                border: InputBorder.none,
                filled: false,
              ),
            ),
          ),
          const Icon(Icons.mic_none, color: MercDealTheme.green),
        ],
      ),
    );
  }

  Widget _chips() {
    const filters = ['Consigliati', 'Sta scendendo', 'Quasi al minimo', 'Nuovi', 'Fine imminente'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(filter),
              selected: selected == filter,
              onSelected: (_) => setState(() => selected = filter),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _listingTile(BuildContext context, Listing x) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ListingDetailScreen(listing: x)),
        ),
        borderRadius: BorderRadius.circular(21),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: MercDealTheme.card,
            borderRadius: BorderRadius.circular(21),
            border: Border.all(color: Colors.white.withValues(alpha: .06)),
          ),
          child: Row(
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(colors: [Color(0xFF142C40), Color(0xFF091521)]),
                ),
                child: Icon(x.icon, size: 40, color: MercDealTheme.green),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(x.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w900)),
                        ),
                        if (x.verifiedSeller) const Icon(Icons.verified_rounded, color: MercDealTheme.green, size: 17),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text('${x.category} · ${x.location}', style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    const SizedBox(height: 7),
                    Text('€${x.price.toStringAsFixed(2).replaceAll('.', ',')}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 3),
                    Text(
                      x.mode == SaleMode.descendingAuction
                          ? '📉 −€0,20 oggi · ${x.followers} seguono'
                          : '🤝 Proposta libera',
                      style: const TextStyle(color: MercDealTheme.green, fontSize: 11, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
