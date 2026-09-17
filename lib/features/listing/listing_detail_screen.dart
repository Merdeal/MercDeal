import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
import '../../models/listing.dart';

class ListingDetailScreen extends StatefulWidget {
  final Listing listing;
  const ListingDetailScreen({super.key, required this.listing});
  @override State<ListingDetailScreen> createState() => _ListingDetailScreenState();
}

class _ListingDetailScreenState extends State<ListingDetailScreen> {
  bool following = false;

  @override
  Widget build(BuildContext context) {
    final x = widget.listing;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dettaglio affare', style: TextStyle(fontWeight: FontWeight.w900)),
        actions: [IconButton(onPressed: () => setState(() => following = !following), icon: Icon(following ? Icons.favorite : Icons.favorite_border, color: following ? MercDealTheme.green : null))],
      ),
      body: ListView(padding: const EdgeInsets.fromLTRB(18, 8, 18, 30), children: [
        Container(height: 245, decoration: BoxDecoration(borderRadius: BorderRadius.circular(28), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF16364C), Color(0xFF091521)])), child: Icon(x.icon, size: 95, color: MercDealTheme.green)),
        const SizedBox(height: 18),
        Row(children: [Expanded(child: Text(x.title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900))), if (x.verifiedSeller) const Icon(Icons.verified_rounded, color: MercDealTheme.green)]),
        const SizedBox(height: 5),
        Text('${x.category} · ${x.location}', style: const TextStyle(color: Colors.white54)),
        const SizedBox(height: 18),
        if (x.mode == SaleMode.descendingAuction) _auction(x),
        const SizedBox(height: 18),
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: MercDealTheme.card, borderRadius: BorderRadius.circular(20)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Venditore verificato', style: TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(height: 5),
          const Text('🟢 ✓ Venditore verificato', style: TextStyle(color: MercDealTheme.green, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Text('Condizioni: ${_condition(x.condition)}', style: const TextStyle(color: Colors.white60)),
          const SizedBox(height: 4),
          const Text('Pagamento protetto disponibile per la spedizione.', style: TextStyle(color: Colors.white60)),
        ])),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: GlowButton(label: 'Fai un’offerta', icon: Icons.handshake_rounded, secondary: true, onPressed: () => _offer(context))),
          const SizedBox(width: 10),
          Expanded(child: GlowButton(label: 'Compralo', icon: Icons.shopping_cart_checkout_rounded, onPressed: () => _buy(context))),
        ]),
      ]),
    );
  }

  Widget _auction(Listing x) {
    final price = x.price.toStringAsFixed(2).replaceAll('.', ',');
    return Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: const Color(0xFF0D2130), borderRadius: BorderRadius.circular(22), border: Border.all(color: MercDealTheme.green.withValues(alpha: .2))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('📉 ASTA AL RIBASSO', style: TextStyle(color: MercDealTheme.green, fontWeight: FontWeight.w900, letterSpacing: 1)),
      const SizedBox(height: 5),
      Text('€$price', style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w900)),
      const SizedBox(height: 4),
      const Text('−€0,20 al giorno · minimo del venditore nascosto', style: TextStyle(color: Colors.white54, fontSize: 12)),
      const SizedBox(height: 14),
      ClipRRect(borderRadius: BorderRadius.circular(8), child: LinearProgressIndicator(value: x.progress, minHeight: 8, color: MercDealTheme.green, backgroundColor: Colors.white10)),
      const SizedBox(height: 12),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Partenza €${x.startPrice.toStringAsFixed(2).replaceAll('.', ',')}', style: const TextStyle(color: const Color(0x61FFFFFF), fontSize: 11)), Text('Minimo privato', style: const TextStyle(color: const Color(0x61FFFFFF), fontSize: 11))]),
      const SizedBox(height: 12),
      Text('${x.followers} persone stanno seguendo questo affare', style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700)),
    ]));
  }

  String _condition(ListingCondition c) => switch (c) { ListingCondition.newItem => 'Nuovo', ListingCondition.excellent => 'Ottime condizioni', ListingCondition.good => 'Buone condizioni', ListingCondition.fair => 'Condizioni discrete' };

  void _offer(BuildContext context) {
    final controller = TextEditingController();
    showModalBottomSheet<void>(context: context, isScrollControlled: true, backgroundColor: MercDealTheme.card, builder: (_) => Padding(padding: EdgeInsets.fromLTRB(18, 18, 18, MediaQuery.of(context).viewInsets.bottom + 18), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Fai un’offerta', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
      const SizedBox(height: 7),
      const Text('Prima di confermare vedrai sempre il costo di spedizione e il totale.', style: TextStyle(color: Colors.white54)),
      const SizedBox(height: 14),
      TextField(controller: controller, keyboardType: TextInputType.number, decoration: const InputDecoration(prefixText: '€ ', hintText: 'Importo offerta')),
      const SizedBox(height: 14),
      GlowButton(label: 'Continua', onPressed: () => Navigator.pop(context)),
    ])));
  }

  void _buy(BuildContext context) {
    showModalBottomSheet<void>(context: context, backgroundColor: MercDealTheme.card, builder: (_) => Padding(padding: const EdgeInsets.all(18), child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text('Scegli consegna', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
      const SizedBox(height: 10),
      const ListTile(leading: Icon(Icons.local_shipping_outlined, color: MercDealTheme.green), title: Text('Spedizione'), subtitle: Text('Inserisci il CAP e vedi il costo esatto prima del pagamento')),
      const ListTile(leading: Icon(Icons.location_on_outlined, color: MercDealTheme.blue), title: Text('Ritiro a mano'), subtitle: Text('Il venditore indica il punto d’incontro dopo l’acquisto')),
      const SizedBox(height: 5),
      GlowButton(label: 'Vai al checkout', onPressed: () => Navigator.pop(context)),
    ])));
  }
}
