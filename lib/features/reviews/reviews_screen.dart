import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});
  @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Recensioni',style:TextStyle(fontWeight:FontWeight.w900))),body:ListView(padding:const EdgeInsets.all(18),children:[
    Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFF12382F),Color(0xFF0B1826)]),borderRadius:BorderRadius.circular(23)),child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('4,9',style:TextStyle(fontSize:43,fontWeight:FontWeight.w900)),Text('★★★★★',style:TextStyle(color:MercDealTheme.green,fontSize:21)),SizedBox(height:8),Text('La reputazione nasce dalle transazioni realmente concluse.',style:TextStyle(color:Colors.white54))])),
    const SizedBox(height:15),_review('Marco','Comunicazione chiara e ritiro puntuale.'),_review('Giulia','Oggetto conforme alla descrizione.'),_review('Davide','Spedizione precisa e imballaggio curato.'),const SizedBox(height:12),GlowButton(label:'Lascia una recensione',icon:Icons.star_outline,onPressed:()=>ScaffoldMessenger.of(c).showSnackBar(const SnackBar(content:Text('La recensione sarà disponibile dopo una transazione conclusa.'))))
  ]));
  static Widget _review(String n,String t)=>Container(margin:const EdgeInsets.only(bottom:10),padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:MercDealTheme.card,borderRadius:BorderRadius.circular(18)),child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[const CircleAvatar(backgroundColor:Color(0xFF153247),child:Icon(Icons.person_outline,color:Colors.white70)),const SizedBox(width:11),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(n,style:const TextStyle(fontWeight:FontWeight.w900)),const Text('★★★★★',style:TextStyle(color:MercDealTheme.green)),const SizedBox(height:3),Text(t,style:const TextStyle(color:Colors.white60))]))]));
}
