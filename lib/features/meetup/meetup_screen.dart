import 'dart:async';
import 'package:flutter/material.dart';
import '../../app/theme.dart';import '../../core/widgets/merc_widgets.dart';
class MeetupScreen extends StatefulWidget{const MeetupScreen({super.key});@override State<MeetupScreen> createState()=>_MeetupScreenState();}
class _MeetupScreenState extends State<MeetupScreen>{bool shared=false,arrived=false,closed=false;Timer? timer;@override void dispose(){timer?.cancel();super.dispose();}
 @override Widget build(BuildContext context){
  return Scaffold(appBar:AppBar(title:const Text('Ritiro a mano',style:TextStyle(fontWeight:FontWeight.w900))),body:ListView(padding:const EdgeInsets.fromLTRB(16,8,16,30),children:[
   const Text('📍 Ecco dove devi incontrare il venditore',style:TextStyle(fontSize:22,fontWeight:FontWeight.w900)),
   const SizedBox(height:6),const Text('Il punto di incontro è scelto dal venditore e può essere modificato tramite la chat dell’ordine.',style:TextStyle(color:Colors.white54)),
   const SizedBox(height:14),
   Container(height:210,decoration:BoxDecoration(borderRadius:BorderRadius.circular(25),gradient:const LinearGradient(colors:[Color(0xFF0B2731),Color(0xFF123B34)]),border:Border.all(color:MercDealTheme.green)),child:const Center(child:Icon(Icons.location_on_rounded,size:65,color:MercDealTheme.green))),
   const SizedBox(height:10),
   const GlassCard(child:Row(children:[Icon(Icons.place_rounded,color:MercDealTheme.green),SizedBox(width:8),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Stazione di Viterbo',style:TextStyle(fontWeight:FontWeight.w900)),Text('Piazza Martiri d’Ungheria · punto di incontro',style:TextStyle(color:Colors.white54,fontSize:10))]))])),
   const SizedBox(height:10),
   GlowButton(label:'💬 Chatta con il venditore',icon:Icons.chat_bubble_outline,onPressed:()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Chat ordine attivata: puoi concordare giorno, ora e luogo.')))),
   const SizedBox(height:8),_info(Icons.event_available,'Ritiro programmato','Sabato · 18:00'),_info(Icons.schedule,'Appuntamento','Confermato da entrambe le parti'),
   const SizedBox(height:8),
   GlassCard(glow:true,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('📍 Posizione temporanea',style:TextStyle(fontSize:18,fontWeight:FontWeight.w900)),const SizedBox(height:5),Text(shared?'🟢 Posizione condivisa · ETA circa 3 minuti':'15 minuti circa prima dell’incontro potrai condividere temporaneamente la posizione, solo con consenso di entrambe le persone.',style:TextStyle(color:shared?MercDealTheme.green:Colors.white54,fontSize:11)),const SizedBox(height:10),if(!shared)GlowButton(label:'Condividi posizione temporaneamente',icon:Icons.my_location,onPressed:()=>setState(()=>shared=true))else Row(children:[const Icon(Icons.navigation_rounded,color:MercDealTheme.blue),const SizedBox(width:8),const Expanded(child:Text('Venditore in arrivo · ETA circa 3 minuti',style:TextStyle(fontWeight:FontWeight.w800))),IconButton(onPressed:()=>setState(()=>shared=false),icon:const Icon(Icons.close))])])),
   const SizedBox(height:10),
   GlassCard(child:Column(children:[Row(children:[Icon(arrived?Icons.check_circle:Icons.location_searching,color:arrived?MercDealTheme.green:MercDealTheme.blue),const SizedBox(width:9),Expanded(child:Text(arrived?'🎉 Siete entrambi arrivati!':'Quando arrivate, tocca “Sono arrivato”. La finestra finale dura 10 minuti.',style:const TextStyle(fontWeight:FontWeight.w800)))]),if(!arrived) ...[const SizedBox(height:10),GlowButton(label:'Sono arrivato',icon:Icons.flag_rounded,onPressed:(){setState(()=>arrived=true);timer=Timer(const Duration(minutes:10),(){if(mounted&&!closed)setState(()=>shared=false);});})] else ...[const SizedBox(height:10),const Text('Finestra finale: 10 minuti',style:TextStyle(color:MercDealTheme.green,fontWeight:FontWeight.w900)),const SizedBox(height:8),GlowButton(label:'AFFARE CONCLUSO · Pagamento a mano',icon:Icons.check_circle_rounded,onPressed:(){setState((){closed=true;shared=false;});ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Affare concluso. La posizione è stata disattivata.')));})]])),
   if(closed) const Padding(padding:EdgeInsets.only(top:10),child:GlassCard(glow:true,child:Row(children:[Icon(Icons.verified_rounded,color:MercDealTheme.green),SizedBox(width:8),Expanded(child:Text('Affare concluso · doppia conferma registrata · posizione terminata',style:TextStyle(color:MercDealTheme.green,fontWeight:FontWeight.w900,fontSize:12)))]))),
  ]));
 }
 Widget _info(IconData icon,String title,String value)=>Padding(padding:const EdgeInsets.only(bottom:8),child:GlassCard(child:Row(children:[Icon(icon,color:MercDealTheme.green),const SizedBox(width:10),Expanded(child:Text(title,style:const TextStyle(fontWeight:FontWeight.w800))),Text(value,style:const TextStyle(color:Colors.white54,fontSize:11))])));
}
