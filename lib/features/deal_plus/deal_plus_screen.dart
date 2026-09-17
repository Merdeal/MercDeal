import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
class DealPlusScreen extends StatelessWidget {
  const DealPlusScreen({super.key});
  @override Widget build(BuildContext c) => Scaffold(appBar:AppBar(title:const Text('Deal+',style:TextStyle(fontWeight:FontWeight.w900))),body:ListView(padding:const EdgeInsets.all(18),children:[
    Container(padding:const EdgeInsets.all(22),decoration:BoxDecoration(borderRadius:BorderRadius.circular(26),gradient:const LinearGradient(colors:[Color(0xFF183E35),Color(0xFF0B1826)]),border:Border.all(color:MercDealTheme.green.withValues(alpha:.22))),child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('💎 DEAL+',style:TextStyle(color:MercDealTheme.green,fontWeight:FontWeight.w900,letterSpacing:1.5)),SizedBox(height:7),Text('Segui l’affare\nsenza perderlo.',style:TextStyle(fontSize:30,fontWeight:FontWeight.w900)),SizedBox(height:9),Text('Più controllo sul prezzo. Più strumenti per trovare il momento giusto.',style:TextStyle(color:Colors.white54,height:1.4))])),
    const SizedBox(height:17),
    _b(Icons.notifications_active_outlined,'Alert prezzo','Imposta una soglia e ricevi una notifica.'),_b(Icons.tune_rounded,'Filtri avanzati','Percentuale ribasso, distanza, fine asta.'),_b(Icons.show_chart_rounded,'Storico prezzo','Segui come cambia il prezzo nel tempo.'),_b(Icons.diamond_outlined,'Vetrina Premium','Una tua inserzione in Vetrina per 7 giorni.'),
    const SizedBox(height:17),
    GlowButton(label:'€4,99 / mese',icon:Icons.arrow_forward_rounded,onPressed:()=>_msg(c)),const SizedBox(height:9),GlowButton(label:'€39,99 / anno',secondary:true,onPressed:()=>_msg(c)),const SizedBox(height:10),const Text('L’abbonamento reale sarà collegato allo store.',textAlign:TextAlign.center,style:TextStyle(color:Colors.white30,fontSize:10))
  ]));
  static Widget _b(IconData i,String t,String s)=>Container(margin:const EdgeInsets.only(bottom:8),padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:MercDealTheme.card,borderRadius:BorderRadius.circular(18)),child:Row(children:[Icon(i,color:MercDealTheme.green),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(t,style:const TextStyle(fontWeight:FontWeight.w900)),Text(s,style:const TextStyle(color:Colors.white38,fontSize:11))]))]));
  static void _msg(BuildContext c)=>ScaffoldMessenger.of(c).showSnackBar(const SnackBar(content:Text('Deal+ pronto per il collegamento allo store.')));
}
