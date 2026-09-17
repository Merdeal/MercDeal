import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
            child: Row(
              children: [
                const Expanded(
                  child: Text('Messaggi', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: MercDealTheme.card,
                borderRadius: BorderRadius.circular(17),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: const Color(0x61FFFFFF)),
                  SizedBox(width: 10),
                  Text('Cerca nelle conversazioni', style: TextStyle(color: const Color(0x61FFFFFF))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              children: const [
                _Chat('Luca · Sony Alpha 7 III', 'Ciao, è ancora disponibile?', '2 min', true, Icons.camera_alt_rounded),
                _Chat('Marco · PS5 Slim', 'Posso passare domani per il ritiro?', '1 h', false, Icons.sports_esports_rounded),
                _Chat('MercDeal', 'Il tuo ordine è stato consegnato.', '3 h', false, Icons.local_shipping_rounded),
                SizedBox(height: 30),
                EmptyState(
                  icon: Icons.forum_outlined,
                  title: 'Parla, tratta, concludi',
                  text: 'Dopo un acquisto a mano compariranno anche gli strumenti per organizzare l’appuntamento.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Chat extends StatelessWidget {
  final String title;
  final String msg;
  final String time;
  final bool unread;
  final IconData icon;

  const _Chat(this.title, this.msg, this.time, this.unread, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: MercDealTheme.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .04),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: MercDealTheme.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text(msg, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white54)),
              ],
            ),
          ),
          Column(
            children: [
              Text(time, style: const TextStyle(color: const Color(0x61FFFFFF), fontSize: 10)),
              if (unread)
                const Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: CircleAvatar(radius: 4, backgroundColor: MercDealTheme.green),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
