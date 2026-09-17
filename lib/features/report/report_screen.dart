import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});
  @override State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final details = TextEditingController();
  bool reviewed = false;
  @override void dispose() { details.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MercDeal Report', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        const Text('Segnala un problema', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
        const SizedBox(height: 7),
        const Text('MercDeal raccoglie gli elementi utili per preparare un dossier della transazione. Il dossier non equivale automaticamente a una denuncia.', style: TextStyle(color: Colors.white54, height: 1.35)),
        const SizedBox(height: 18),
        Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: MercDealTheme.card, borderRadius: BorderRadius.circular(19)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Elementi raccolti', style: TextStyle(fontWeight: FontWeight.w900)),
          SizedBox(height: 8),
          Text('• ordine e annuncio\n• chat rilevante\n• pagamento e stato\n• tracking e spedizione\n• video imballaggio / apertura\n• Security Seal\n• allegati forniti dalle parti', style: TextStyle(color: Colors.white60, height: 1.55)),
        ])),
        const SizedBox(height: 14),
        TextField(controller: details, maxLines: 5, decoration: const InputDecoration(labelText: 'Descrivi il problema', hintText: 'Cosa è successo?')),
        const SizedBox(height: 10),
        CheckboxListTile(contentPadding: EdgeInsets.zero, value: reviewed, onChanged: (v) => setState(() => reviewed = v ?? false), title: const Text('Ho controllato il riepilogo dei dati da inviare.'), activeColor: MercDealTheme.green),
        const SizedBox(height: 8),
        GlowButton(label: 'Prepara dossier', icon: Icons.folder_zip_outlined, onPressed: reviewed ? () => _showReady(context) : null),
      ]),
    );
  }

  void _showReady(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Dossier pronto'),
        content: const Text('Questa build prepara il flusso. L’invio a servizi esterni sarà collegato nel backend di produzione.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Chiudi'))],
      ),
    );
  }
}
