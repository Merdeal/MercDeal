import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
import '../security/security_screen.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Spedizione', style: TextStyle(fontWeight: FontWeight.w900))), body: ListView(padding: const EdgeInsets.all(18), children: [
    _Step(number: '1', title: 'Pagamento protetto', text: 'Il pagamento resta nel flusso protetto fino alla conclusione secondo le regole dell’ordine.'),
    _Step(number: '2', title: 'Prepara il pacco', text: 'Registra il video imballaggio fino a 1 minuto e applica il Security Seal.'),
    _Step(number: '3', title: 'Scarica etichetta', text: 'L’etichetta sarà disponibile nell’Area Venditore e potrà essere inviata anche via email.'),
    _Step(number: '4', title: 'Tracking', text: 'Il tracking si aggiorna automaticamente quando il provider di spedizione è collegato.'),
    _Step(number: '5', title: 'Consegna e verifica', text: 'Dopo la consegna l’acquirente può verificare l’oggetto e segnalare un problema.'),
    const SizedBox(height: 12),
    Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFF102B25), borderRadius: BorderRadius.circular(18)), child: const Row(children: [Icon(Icons.shield_outlined, color: MercDealTheme.green), SizedBox(width: 10), Expanded(child: Text('Il costo di spedizione viene mostrato prima dell’acquisto o della conferma di un’offerta.', style: TextStyle(fontWeight: FontWeight.w700)))])),
    const SizedBox(height: 15),
    GlowButton(label: 'Sicurezza della transazione', icon: Icons.security_outlined, onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SecurityScreen()))),
  ]));
}
class _Step extends StatelessWidget { final String number,title,text; const _Step({required this.number,required this.title,required this.text}); @override Widget build(BuildContext context)=>Container(margin:const EdgeInsets.only(bottom:10),padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:MercDealTheme.card,borderRadius:BorderRadius.circular(19)),child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Container(width:34,height:34,decoration:const BoxDecoration(shape:BoxShape.circle,color:MercDealTheme.green),alignment:Alignment.center,child:Text(number,style:const TextStyle(color:Color(0xFF04120B),fontWeight:FontWeight.w900))),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontWeight:FontWeight.w900)),const SizedBox(height:4),Text(text,style:const TextStyle(color:Colors.white54,height:1.35))]))])); }
