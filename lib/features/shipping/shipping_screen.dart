import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
import '../security/security_screen.dart';
class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});
  @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Spedizione',style:TextStyle(fontWeight:FontWeight.w900))),body:ListView(padding:const EdgeInsets.all(18),children:[
    _s('1','Pagamento protetto','Il pagamento resta nel flusso protetto secondo le regole dell’ordine.'),_s('2','Video imballaggio','Registra massimo 1 minuto: oggetto, condizioni, protezioni e chiusura.'),_s('3','Security Seal','Applica il sigillo stampabile MercDeal con codice e QR.'),_s('4','Etichetta','Scaricala dall’Area Venditore; può essere disponibile via email.'),_s('5','Tracking','Gli aggiornamenti arrivano automaticamente quando il provider è collegato.'),_s('6','Consegna e verifica','L’acquirente controlla l’oggetto e può confermare o segnalare.'),
    Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:const Color(0xFF102B25),borderRadius:BorderRadius.circular(18)),child:const Row(children:[Icon(Icons.shield_outlined,color:MercDealTheme.green),SizedBox(width:10),Expanded(child:Text('Il costo di spedizione deve essere mostrato prima dell’acquisto o dell’offerta.',style:TextStyle(fontWeight:FontWeight.w700)))])),const SizedBox(height:14),GlowButton(label:'Sicurezza della transazione',icon:Icons.security_outlined,onPressed:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>const SecurityScreen())))
  ]));
  static Widget _s(String n,String t,String x)=>Container(margin:const EdgeInsets.only(bottom:9),padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:MercDealTheme.card,borderRadius:BorderRadius.circular(18)),child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Container(width:34,height:34,alignment:Alignment.center,decoration:const BoxDecoration(color:MercDealTheme.green,shape:BoxShape.circle),child:Text(n,style:const TextStyle(color:Color(0xFF04120B),fontWeight:FontWeight.w900))),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(t,style:const TextStyle(fontWeight:FontWeight.w900)),const SizedBox(height:4),Text(x,style:const TextStyle(color:Colors.white54,height:1.35))]))]));
}
