import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          const Text('Messaggi', style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          const Text('Chat, offerte e trattative.', style: TextStyle(color: Colors.white54)),
          const SizedBox(height: 16),
          _chat(context, 'LucaR', 'iPhone 14 Pro 128GB', 'Ci vediamo oggi alle 18:00?', '2 min', true),
          _chat(context, 'SaraM', 'PS5', 'Posso fare €300?', '18 min', false),
          _chat(context, 'MarcoP', 'Action Cam 12', 'Controproposta ricevuta', '1 h', true),
          const SizedBox(height: 14),
          const GlassCard(child: Row(children: [
            Icon(Icons.lock_outline, color: MercDealTheme.green),
            SizedBox(width: 10),
            Expanded(child: Text('Prima dell’acquisto: messaggi, foto, offerte e controfferte. Gli appuntamenti si attivano solo dopo acquisto + ritiro a mano.', style: TextStyle(color: Colors.white60, fontSize: 11))),
          ])),
        ],
      ),
    );
  }
  Widget _chat(BuildContext context, String name, String item, String message, String time, bool online) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: GlassCard(
        onTap: () => _open(context, name, item),
        child: Row(children: [
          const CircleAvatar(backgroundColor: MercDealTheme.card2, child: Icon(Icons.person_rounded)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Text(name, style: const TextStyle(fontWeight: FontWeight.w900)), if (online) const Padding(padding: EdgeInsets.only(left: 5), child: Icon(Icons.circle, color: MercDealTheme.green, size: 8))]),
            Text(item, style: const TextStyle(color: MercDealTheme.green, fontSize: 10)),
            Text(message, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white60, fontSize: 11)),
          ])),
          Text(time, style: const TextStyle(color: Colors.white38, fontSize: 9)),
        ]),
      ),
    );
  }
  void _open(BuildContext context, String name, String item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: MercDealTheme.card,
      builder: (sheet) => Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 18, bottom: MediaQuery.of(sheet).viewInsets.bottom + 18),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(children: [const CircleAvatar(child: Icon(Icons.person_rounded)), const SizedBox(width: 9), Expanded(child: Text(name, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900))), const Icon(Icons.more_vert)]),
          const SizedBox(height: 12),
          GlassCard(child: Text('Ciao! Parliamo dell’annuncio $item. Dopo l’acquisto, se scegli Ritiro a mano, qui appariranno appuntamento e punto di incontro.', style: const TextStyle(color: Colors.white70, height: 1.4))),
          const SizedBox(height: 10),
          const TextField(decoration: InputDecoration(hintText: 'Scrivi un messaggio…', suffixIcon: Icon(Icons.send_rounded))),
        ]),
      ),
    );
  }
}
