import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
import '../report/report_screen.dart';
class SecurityScreen extends StatelessWidget{const SecurityScreen({super.key});
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Sicurezza',style:TextStyle(fontWeight:FontWeight.w900))),body:ListView(padding:const EdgeInsets.all(16),children:[
  const GlassCard(glow:true,child:Row(children:[Icon(Icons.shield_rounded,color:MercDealTheme.green,size:42),SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Centro sicurezza',style:TextStyle(fontSize:21,fontWeight:FontWeight.w900)),Text('Account, acquisti, vendite, spedizioni, ritiri e contestazioni.',style:TextStyle(color:Colors.white54,fontSize:11))]))])),const SizedBox(height:12),
  _item(Icons.verified_user_outlined,'Verifica venditore','Obbligatoria per pubblicare annunci e ricevere pagamenti delle vendite con spedizione.'),
  _item(Icons.payment_outlined,'Pagamenti','Per spedizioni il pagamento segue il flusso protetto; per il ritiro il pagamento avviene direttamente al venditore.'),
  _item(Icons.videocam_outlined,'MercDeal Proof','Video imballaggio max 1 minuto, tracking, peso quando disponibile e altre prove collegate all’ordine.'),
  _item(Icons.location_on_outlined,'Ritiro sicuro','Punto scelto dal venditore, appuntamento dopo l’acquisto e posizione temporanea solo con consenso reciproco.'),
  _item(Icons.gavel_outlined,'Contestazioni','Raccogli evidenze dell’ordine e valuta il problema secondo le regole della piattaforma.'),
  const SizedBox(height:10),GlowButton(label:'🚨 Apri MercDeal Report',icon:Icons.report_problem_outlined,onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const ReportScreen())))
 ]));
 Widget _item(IconData icon,String title,String text)=>Padding(padding:const EdgeInsets.only(bottom:8),child:GlassCard(child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(icon,color:MercDealTheme.green),const SizedBox(width:11),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontWeight:FontWeight.w900)),const SizedBox(height:3),Text(text,style:const TextStyle(color:Colors.white54,fontSize:11,height:1.4))]))])));
}
