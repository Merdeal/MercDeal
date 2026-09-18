import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
import '../../models/listing.dart';
import '../checkout/checkout_screen.dart';

class ListingDetailScreen extends StatefulWidget {
  final Listing listing;
  const ListingDetailScreen({super.key, required this.listing});
  @override State<ListingDetailScreen> createState()=>_ListingDetailScreenState();
}
class _ListingDetailScreenState extends State<ListingDetailScreen> {
  bool following=false;
  @override Widget build(BuildContext context){
    final x=widget.listing;
    return Scaffold(
      appBar:AppBar(actions:[
        IconButton(onPressed:()=>setState(()=>following=!following),icon:Icon(following?Icons.favorite:Icons.favorite_border,color:following?MercDealTheme.green:null)),
        IconButton(onPressed:()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Annuncio condiviso'))),icon:const Icon(Icons.share_rounded)),
      ]),
      body:ListView(
        padding:const EdgeInsets.fromLTRB(16,0,16,30),
        children:[
          Stack(children:[
            ClipRRect(borderRadius:BorderRadius.circular(26),child:Image.asset('assets/images/${x.asset}',height:290,width:double.infinity,fit:BoxFit.cover)),
            Positioned(left:12,top:12,child:PriceBadge(x.dropLabel)),
            const Positioned(right:12,bottom:12,child:PriceBadge('1/6')),
          ]),
          const SizedBox(height:14),
          Text(x.title,style:const TextStyle(fontSize:25,fontWeight:FontWeight.w900)),
          Text('${x.category} · ${x.location} · Come nuovo',style:const TextStyle(color:Colors.white54)),
          const SizedBox(height:9),
          Row(children:[Text(x.oldPriceLabel,style:const TextStyle(color:Colors.white38,decoration:TextDecoration.lineThrough)),const SizedBox(width:10),Text(x.priceLabel,style:const TextStyle(color:MercDealTheme.green,fontSize:29,fontWeight:FontWeight.w900)),const SizedBox(width:9),PriceBadge(x.dropLabel)]),
          const SizedBox(height:12),
          const GlassCard(glow:true,child:Row(children:[Icon(Icons.timer_outlined,color:MercDealTheme.green),SizedBox(width:10),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Prossima riduzione',style:TextStyle(fontWeight:FontWeight.w900)),Text('tra 00:12:34 · nuovo ribasso giornaliero',style:TextStyle(color:MercDealTheme.green,fontWeight:FontWeight.w800,fontSize:11))]))])),
          const SizedBox(height:12),
          Row(children:[
            Expanded(child:FilledButton.icon(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>CheckoutScreen(listing:x))),icon:const Icon(Icons.shopping_cart_rounded),label:Text('Compra ora\n${x.priceLabel}',textAlign:TextAlign.center),style:FilledButton.styleFrom(backgroundColor:MercDealTheme.green,foregroundColor:Colors.black,minimumSize:const Size.fromHeight(58)))),
            const SizedBox(width:8),
            Expanded(child:OutlinedButton.icon(onPressed:()=>_offer(context),icon:const Icon(Icons.gavel_rounded),label:const Text('Fai un’offerta'),style:OutlinedButton.styleFrom(minimumSize:const Size.fromHeight(58)))),
          ]),
          const SizedBox(height:8),
          OutlinedButton.icon(onPressed:()=>setState(()=>following=!following),icon:Icon(following?Icons.favorite:Icons.favorite_border),label:Text(following?'Stai seguendo questo affare':'Segui l’affare'),style:OutlinedButton.styleFrom(minimumSize:const Size.fromHeight(50))),
          const SizedBox(height:12),
          Row(children:[_metric(Icons.visibility_outlined,'124','visualizzazioni'),_metric(Icons.people_outline,'${x.followers}','lo seguono'),_metric(Icons.gavel_rounded,'${x.offers}','offerte')]),
          const SizedBox(height:12),
          const GlassCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Venditore',style:TextStyle(fontSize:18,fontWeight:FontWeight.w900)),SizedBox(height:10),Row(children:[CircleAvatar(backgroundColor:MercDealTheme.card2,child:Icon(Icons.person_rounded)),SizedBox(width:10),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Venditore verificato',style:TextStyle(fontWeight:FontWeight.w900)),Text('🟢 ✓ Profilo verificato · reputazione reale',style:TextStyle(color:MercDealTheme.green,fontSize:11))]))])])),
          const SizedBox(height:10),
          _info('🚚 Spedizione','Disponibile · costo visibile prima dell’acquisto'),
          _info('📍 Ritiro a mano','Disponibile · punto deciso dal venditore'),
          _info('🛡️ Pagamento protetto','Per spedizioni il pagamento segue il flusso protetto MercDeal'),
          _info('📹 MercDeal Proof','Video imballaggio massimo 1 minuto collegato all’ordine'),
          const SizedBox(height:8),
          const GlassCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Descrizione',style:TextStyle(fontSize:18,fontWeight:FontWeight.w900)),SizedBox(height:7),Text('Articolo in condizioni come da foto. Il venditore dichiara che l’oggetto è conforme alla descrizione. Le prove private, quando previste, vengono collegate al dossier dell’ordine.',style:TextStyle(color:Colors.white70,height:1.45)),SizedBox(height:9),Text('📉 Asta al ribasso: il prezzo scende secondo le regole dell’annuncio fino al minimo impostato dal venditore.',style:TextStyle(color:MercDealTheme.green,fontWeight:FontWeight.w800,fontSize:11))])),
        ],
      ),
    );
  }
  Widget _metric(IconData icon,String value,String label)=>Expanded(child:Column(children:[Icon(icon,color:MercDealTheme.green),Text(value,style:const TextStyle(fontWeight:FontWeight.w900)),Text(label,style:const TextStyle(color:Colors.white38,fontSize:9))]));
  Widget _info(String title,String text)=>Padding(padding:const EdgeInsets.only(bottom:8),child:GlassCard(child:Row(children:[Text(title,style:const TextStyle(fontWeight:FontWeight.w900)),const SizedBox(width:8),Expanded(child:Text(text,textAlign:TextAlign.right,style:const TextStyle(color:Colors.white54,fontSize:10)))])));
  void _offer(BuildContext context){final controller=TextEditingController();showModalBottomSheet(context:context,isScrollControlled:true,backgroundColor:MercDealTheme.card,builder:(sheet)=>Padding(padding:EdgeInsets.only(left:20,right:20,top:20,bottom:MediaQuery.of(sheet).viewInsets.bottom+20),child:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Fai un’offerta',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900)),const SizedBox(height:5),const Text('Prima di confermare vedrai anche il costo di spedizione per la destinazione scelta.',style:TextStyle(color:Colors.white54,fontSize:11)),const SizedBox(height:10),TextField(controller:controller,keyboardType:TextInputType.number,decoration:const InputDecoration(prefixText:'€ ',labelText:'La tua offerta')),const SizedBox(height:12),GlowButton(label:'Invia proposta',icon:Icons.send_rounded,onPressed:(){Navigator.pop(sheet);ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Offerta inviata al venditore')));})])));}
}
