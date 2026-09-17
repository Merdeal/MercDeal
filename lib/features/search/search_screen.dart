import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../models/listing.dart';
import '../listing/listing_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  final q = TextEditingController();
  bool auction = true;
  bool verified = false;
  bool shipping = true;
  double max = 1500;
  final items = const [
    Listing(id:'1', title:'Sony Alpha 7 III', category:'Fotografia', price:1179.8, startPrice:1240, minimumPrice:1090, drop:.2, followers:18, icon:Icons.camera_alt_rounded, mode:SaleMode.descendingAuction, condition:ListingCondition.excellent, verifiedSeller:true, inShowcase:true, location:'Roma'),
    Listing(id:'2', title:'PlayStation 5 Slim', category:'Gaming', price:454.8, startPrice:520, minimumPrice:420, drop:.2, followers:34, icon:Icons.sports_esports_rounded, mode:SaleMode.descendingAuction, condition:ListingCondition.excellent, verifiedSeller:true, inShowcase:false, location:'Milano'),
    Listing(id:'3', title:'iPad Air', category:'Elettronica', price:399.8, startPrice:450, minimumPrice:350, drop:.2, followers:41, icon:Icons.tablet_mac_rounded, mode:SaleMode.descendingAuction, condition:ListingCondition.good, verifiedSeller:true, inShowcase:false, location:'Bologna'),
  ];
  @override Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18,18,18,30),
        children: [
          const Text('Cerca il tuo affare', style: TextStyle(fontSize:28,fontWeight:FontWeight.w900)),
          const SizedBox(height:5),
          const Text('Filtra il mercato e trova dove il prezzo sta scendendo.', style: TextStyle(color:Colors.white54)),
          const SizedBox(height:17),
          TextField(controller:q, decoration:const InputDecoration(hintText:'Sony, PS5, bici, Rolex…',prefixIcon:Icon(Icons.search_rounded),suffixIcon:Icon(Icons.mic_none_rounded))),
          const SizedBox(height:14),
          Row(children:[Expanded(child:FilledButton.icon(onPressed:()=>_filters(context),icon:const Icon(Icons.tune_rounded,size:17),label:const Text('Filtri'),style:FilledButton.styleFrom(backgroundColor:MercDealTheme.card,foregroundColor:Colors.white,minimumSize:const Size.fromHeight(46)))),const SizedBox(width:8),Expanded(child:FilledButton.icon(onPressed:()=>_sort(context),icon:const Icon(Icons.sort_rounded,size:17),label:const Text('Ordina'),style:FilledButton.styleFrom(backgroundColor:MercDealTheme.card,foregroundColor:Colors.white,minimumSize:const Size.fromHeight(46))))]),
          const SizedBox(height:18),
          const Text('Categorie',style:TextStyle(fontSize:19,fontWeight:FontWeight.w900)),
          const SizedBox(height:10),
          Wrap(spacing:8,runSpacing:8,children:['Elettronica','Gaming','Moda','Casa','Fotografia','Sport','Auto e Moto','Gioielli'].map((e)=>Chip(label:Text(e))).toList()),
          const SizedBox(height:20),
          Row(children:[const Expanded(child:Text('Risultati',style:TextStyle(fontSize:20,fontWeight:FontWeight.w900))),Text('${items.length} affari',style:const TextStyle(color:Colors.white38,fontSize:12))]),
          const SizedBox(height:10),
          ...items.map((x)=>_result(context,x)),
        ],
      ),
    );
  }
  Widget _result(BuildContext context, Listing x) {
    return Container(
      margin: const EdgeInsets.only(bottom:11), padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color:MercDealTheme.card,borderRadius:BorderRadius.circular(20),border:Border.all(color:Colors.white.withValues(alpha:.05))),
      child: Material(color:Colors.transparent,child:InkWell(borderRadius:BorderRadius.circular(18),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>ListingDetailScreen(listing:x))),child:Row(children:[
        Container(width:84,height:84,decoration:BoxDecoration(borderRadius:BorderRadius.circular(16),gradient:const LinearGradient(colors:[Color(0xFF153247),Color(0xFF0A1521)])),child:Icon(x.icon,size:38,color:MercDealTheme.green)),
        const SizedBox(width:12),
        Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Expanded(child:Text(x.title,style:const TextStyle(fontWeight:FontWeight.w900))),if(x.verifiedSeller)const Icon(Icons.verified_rounded,color:MercDealTheme.green,size:17)]),const SizedBox(height:4),Text('${x.category} · ${x.location}',style:const TextStyle(color:Colors.white38,fontSize:11)),const SizedBox(height:6),Row(children:[Text('€${x.price.toStringAsFixed(2).replaceAll('.',',')}',style:const TextStyle(fontSize:19,fontWeight:FontWeight.w900)),const SizedBox(width:8),const Text('−€0,20/giorno',style:TextStyle(color:MercDealTheme.green,fontSize:10,fontWeight:FontWeight.w800))])]))
      ])))
    );
  }
  void _filters(BuildContext context) {
    showModalBottomSheet(context:context,backgroundColor:MercDealTheme.card,isScrollControlled:true,builder:(_)=>StatefulBuilder(builder:(sheet,setSheet)=>Padding(padding:const EdgeInsets.all(20),child:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children:[
      const Text('Filtri avanzati',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900)),
      SwitchListTile(contentPadding:EdgeInsets.zero,value:auction,onChanged:(v)=>setSheet(()=>auction=v),title:const Text('Solo aste al ribasso')),
      SwitchListTile(contentPadding:EdgeInsets.zero,value:verified,onChanged:(v)=>setSheet(()=>verified=v),title:const Text('Venditore verificato')),
      SwitchListTile(contentPadding:EdgeInsets.zero,value:shipping,onChanged:(v)=>setSheet(()=>shipping=v),title:const Text('Spedizione disponibile')),
      Text('Budget massimo · €${max.round()}',style:const TextStyle(fontWeight:FontWeight.w800)),
      Slider(value:max,min:50,max:1500,onChanged:(v)=>setSheet(()=>max=v),activeColor:MercDealTheme.green),
      FilledButton(onPressed:()=>Navigator.pop(sheet),style:FilledButton.styleFrom(backgroundColor:MercDealTheme.green,foregroundColor:const Color(0xFF04120B),minimumSize:const Size.fromHeight(50)),child:const Text('Applica filtri',style:TextStyle(fontWeight:FontWeight.w900))),
    ]))));
  }
  void _sort(BuildContext context) {
    showModalBottomSheet(context:context,backgroundColor:MercDealTheme.card,builder:(sheet)=>Column(mainAxisSize:MainAxisSize.min,children:['Consigliati','Maggiore ribasso','Più recenti','Prezzo più basso','In scadenza','Più seguiti'].map((e)=>ListTile(title:Text(e),onTap:()=>Navigator.pop(sheet))).toList()));
  }
}
