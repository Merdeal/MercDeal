import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
import '../orders/orders_screen.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spedizione', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(padding: const EdgeInsets.fromLTRB(16, 8, 16, 30), children: [
        const Text('Percorso spedizione', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        const Text('Pagamento protetto → Proof → tracking → consegna → verifica.', style: TextStyle(color: Colors.white54)),
        const SizedBox(height: 18),
        _step('1','💳','Pagamento protetto','Il pagamento viene gestito nel flusso sicuro dell’ordine.'),
        _step('2','📹','Video imballaggio','Massimo 1 minuto: prodotto, condizioni, imballaggio e chiusura.'),
        _step('3','🚚','Etichetta e spedizione','L’etichetta viene resa disponibile nell’Area Venditore e inviata via email.'),
        _step('4','📍','Tracking','Gli aggiornamenti della spedizione vengono collegati all’ordine.'),
        _step('5','📦','Consegna e verifica','L’acquirente controlla l’oggetto e può confermare o segnalare un problema.'),
        _step('6','🔓','Rilascio fondi','I fondi vengono rilasciati al venditore secondo le regole della transazione.'),
        const SizedBox(height: 12),
        const GlassCard(glow: true, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('🔐 Security Seal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          SizedBox(height: 5),
          Text('Soluzione stampabile da definire: codice univoco, QR e identificativo ordine. Un sigillo stampabile è un supporto di prova, non una garanzia assoluta.', style: TextStyle(color: Colors.white60, fontSize: 12, height: 1.4)),
        ])),
        const SizedBox(height: 14),
        GlowButton(label: 'Vai ai miei ordini', icon: Icons.shopping_bag_outlined, onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrdersScreen()))),
      ]),
    );
  }
  Widget _step(String number, String icon, String title, String subtitle) => Padding(
    padding: const EdgeInsets.only(bottom: 9),
    child: GlassCard(glow: true, child: Row(children: [
      CircleAvatar(backgroundColor: MercDealTheme.green, foregroundColor: Colors.black, child: Text(number, style: const TextStyle(fontWeight: FontWeight.w900))),
      const SizedBox(width: 12), Text(icon, style: const TextStyle(fontSize: 23)), const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w900)), Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 11))])),
    ])),
  );
}
