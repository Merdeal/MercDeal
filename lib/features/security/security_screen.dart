import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../report/report_screen.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sicurezza MercDeal', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const _SecurityItem(icon: Icons.videocam_outlined, title: 'Video imballaggio', text: 'Il venditore può registrare un video privato dell’oggetto e della chiusura del pacco.'),
          const _SecurityItem(icon: Icons.qr_code_2_rounded, title: 'Security Seal', text: 'Un codice/QR associato all’ordine può essere stampato e applicato sulla chiusura del pacco.'),
          const _SecurityItem(icon: Icons.verified_outlined, title: 'MercDeal Authenticity', text: 'Per categorie supportate raccogliamo documentazione e verifiche dedicate. Una foto da sola non certifica l’autenticità.'),
          const _SecurityItem(icon: Icons.gavel_rounded, title: 'Contestazioni', text: 'Le evidenze possono includere ordine, chat, tracking, video, peso del pacco e materiali forniti dalle parti.'),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportScreen())),
            icon: const Icon(Icons.report_outlined),
            label: const Text('Apri MercDeal Report'),
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFF35191D), foregroundColor: Colors.white, minimumSize: const Size.fromHeight(52)),
          ),
        ],
      ),
    );
  }
}

class _SecurityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const _SecurityItem({required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: MercDealTheme.card, borderRadius: BorderRadius.circular(19)),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: MercDealTheme.green, size: 28),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
        const SizedBox(height: 5),
        Text(text, style: const TextStyle(color: Colors.white54, height: 1.35)),
      ])),
    ]),
  );
}
