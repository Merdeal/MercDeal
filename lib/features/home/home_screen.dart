import 'dart:async';
import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
import '../../models/listing.dart';
import '../listing/listing_detail_screen.dart';
import '../search/search_screen.dart';
import '../notifications/notifications_screen.dart';
import '../deal_plus/deal_plus_screen.dart';
import '../how_it_works/how_it_works_screen.dart';

class HomeScreen extends StatefulWidget { const HomeScreen({super.key}); @override State<HomeScreen> createState()=>_HomeScreenState(); }
class _HomeScreenState extends State<HomeScreen>{
 Timer? timer; int tick=0;
 final products=const <Listing>[
  Listing(id:'1',title:'iPhone 14 Pro 128GB',category:'Elettronica',priceLabel:'€599,00',oldPriceLabel:'€999,00',dropLabel:'-40%',asset:'phone.png',location:'Viterbo',price:599,startPrice:999,minimumPrice:550,drop:5,mode:SaleMode.descendingAuction,condition:ListingCondition.likeNew,verifiedSeller:true,showcase:false,followers:124,offers:18),
  Listing(id:'2',title:'Samsung Galaxy Watch 6',category:'Elettronica',priceLabel:'€224,00',oldPriceLabel:'€299,00',dropLabel:'-25%',asset:'watch.png',location:'Roma',price:224,startPrice:299,minimumPrice:210,drop:2,mode:SaleMode.descendingAuction,condition:ListingCondition.excellent,verifiedSeller:true,showcase:true,followers:87,offers:11),
  Listing(id:'3',title:'Nike Air Force',category:'Moda',priceLabel:'€84,00',oldPriceLabel:'€120,00',dropLabel:'-30%',asset:'sneaker.png',location:'Milano',price:84,startPrice:120,minimumPrice:70,drop:1,mode:SaleMode.descendingAuction,condition:ListingCondition.likeNew,verifiedSeller:true,showcase:false,followers:56,offers:7),
  Listing(id:'4',title:'PlayStation 5',category:'Gaming',priceLabel:'€310,00',oldPriceLabel:'€499,00',dropLabel:'-38%',asset:'console.png',location:'Torino',price:310,startPrice:499,minimumPrice:290,drop:3,mode:SaleMode.descendingAuction,condition:ListingCondition.good,verifiedSeller:true,showcase:false,followers:102,offers:12),
  Listing(id:'5',title:'Action Cam 12',category:'Fotografia',priceLabel:'€280,00',oldPriceLabel:'€399,00',dropLabel:'-30%',asset:'camera.png',location:'Bologna',price:280,startPrice:399,minimumPrice:250,drop:4,mode:SaleMode.descendingAuction,condition:ListingCondition.likeNew,verifiedSeller:true,showcase:true,followers:74,offers:8),
  Listing(id:'6',title:'Auricolari Premium',category:'Musica',priceLabel:'€98,00',oldPriceLabel:'€279,00',dropLabel:'-65%',asset:'earbuds.png',location:'Napoli',price:98,startPrice:279,minimumPrice:90,drop:2,mode:SaleMode.descendingAuction,condition:ListingCondition.likeNew,verifiedSeller:true,showcase:false,followers:61,offers:5),
 ];
 @override void initState(){super.initState();timer=Timer.periodic(const Duration(minutes:2),(_){if(mounted)setState(()=>tick++);});}
 @override void dispose(){timer?.cancel();super.dispose();}
 @override Widget build(BuildContext context){final shift=tick%products.length;final items=[...products.skip(shift),...products.take(shift)];return SafeArea(child:ListView(padding:const EdgeInsets.fromLTRB(16,14,16,28),children:[_top(context),const SizedBox(height:14),_search(context),const SizedBox(height:14),_categories(),const SizedBox(height:18),_hero(),const SizedBox(height:18),const SectionHeader(title:'📉 Sta scendendo ora',action:'Vedi tutti'),_row(context,items.take(3).toList()),const SizedBox(height:18),const SectionHeader(title:'🔥 Aste del giorno',action:'Vedi tutti'),_row(context,items.skip(2).take(3).toList()),const SizedBox(height:18),const SectionHeader(title:'⚡ Affari in discesa',action:'Vedi tutti'),_row(context,items.reversed.take(3).toList()),const SizedBox(height:18),const SectionHeader(title:'⏳ Quasi al minimo',action:'Vedi tutti'),_row(context,products.take(3).toList()),const SizedBox(height:18),_special(),const SizedBox(height:18),_showcase(context),const SizedBox(height:18),_discover(context),const SizedBox(height:14),_how(context)]));}
 Widget _top(BuildContext context)=>Row(children:[Container(width:43,height:43,padding:5,decoration:BoxDecoration(color:MercDealTheme.surface,borderRadius:BorderRadius.circular(14),border:Border.all(color:MercDealTheme.green.withValues(alpha:.35))),child:Image.asset('assets/icon/app_icon.png')),const SizedBox(width:9),const Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text.rich(TextSpan(children:[TextSpan(text:'Merc',style:TextStyle(fontSize:22,fontWeight:FontWeight.w900)),TextSpan(text:'Deal',style:TextStyle(fontSize:22,fontWeight:FontWeight.w900,color:MercDealTheme.green))])),Text('Il prezzo scende. L’affare sale.',style:TextStyle(color:Colors.white38,fontSize:9))])),IconButton(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const NotificationsScreen())),icon:const Icon(Icons.notifications_none_rounded)),const CircleAvatar(radius:18,backgroundColor:MercDealTheme.card2,child:Icon(Icons.person_rounded))]);
 Widget _search(BuildContext context)=>TextField(readOnly:true,onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const SearchScreen())),decoration:const InputDecoration(hintText:'Cosa stai cercando?',prefixIcon:Icon(Icons.search_rounded),suffixIcon:Icon(Icons.qr_code_scanner_rounded)));
 Widget _categories(){
  final data=<List<Object>>[
    ['Elettronica',Icons.smartphone_rounded],['Moda',Icons.checkroom_rounded],['Casa',Icons.home_rounded],['Gaming',Icons.sports_esports_rounded],['Auto/Moto',Icons.directions_car_rounded],['Sport',Icons.sports_soccer_rounded],['Foto',Icons.camera_alt_rounded],['Musica',Icons.music_note_rounded],['Gioielli',Icons.watch_rounded],['Altro',Icons.more_horiz_rounded],
  ];
  return SizedBox(
    height:88,
    child:ListView.separated(
      scrollDirection:Axis.horizontal,
      itemCount:data.length,
      separatorBuilder:(_,__)=>const SizedBox(width:9),
      itemBuilder:(_,i)=>SizedBox(
        width:70,
        child:Column(children:[
          Container(width:52,height:52,decoration:BoxDecoration(color:MercDealTheme.card,borderRadius:BorderRadius.circular(17),border:Border.all(color:MercDealTheme.green.withValues(alpha:.16))),child:Icon(data[i][1] as IconData,color:i.isEven?MercDealTheme.green:MercDealTheme.blue)),
          const SizedBox(height:5),
          Text(data[i][0] as String,maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(fontSize:9,fontWeight:FontWeight.w800)),
        ]),
      ),
    ),
  );
 }
 Widget _hero()=>Container(height:154,padding:const EdgeInsets.all(18),decoration:BoxDecoration(borderRadius:BorderRadius.circular(26),gradient:const LinearGradient(colors:[Color(0xFF07372B),Color(0xFF082333),Color(0xFF07121D)]),border:Border.all(color:MercDealTheme.green.withValues(alpha:.35)),boxShadow:const[BoxShadow(color:Color(0x2636F58B),blurRadius:28)]),child:Stack(children:[const Positioned(right:-8,top:-24,child:Icon(Icons.trending_down_rounded,size:145,color:Color(0x2436F58B))),Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('PIÙ TEMPO PASSA,',style:TextStyle(color:MercDealTheme.green,fontWeight:FontWeight.w900,fontSize:14)),const Text('PIÙ IL PREZZO SCENDE',style:TextStyle(fontWeight:FontWeight.w900,fontSize:22)),const SizedBox(height:6),const Text('Trova l’affare prima che sparisca.',style:TextStyle(color:Colors.white70)),const Spacer(),Row(children:[Image.asset('assets/icon/app_icon.png',width:28,height:28),const SizedBox(width:7),const Text('MercDeal',style:TextStyle(fontWeight:FontWeight.w900)),const Spacer(),const Icon(Icons.arrow_downward_rounded,color:MercDealTheme.green,size:28)])]) ]));
 Widget _row(BuildContext context,List<Listing> list)=>SizedBox(height:252,child:ListView.separated(scrollDirection:Axis.horizontal,itemCount:list.length,separatorBuilder:(_,__)=>const SizedBox(width:10),itemBuilder:(_,i)=>DealCard(title:list[i].title,price:list[i].priceLabel,oldPrice:list[i].oldPriceLabel,drop:list[i].dropLabel,asset:list[i].asset,category:list[i].category,showcase:list[i].showcase,onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>ListingDetailScreen(listing:list[i]))))));
 Widget _special()=>const GlassCard(glow:true,child:Row(children:[CircleAvatar(backgroundColor:Color(0x1636F58B),child:Icon(Icons.visibility_outlined,color:MercDealTheme.green)),SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('👀 Potrebbe sparire',style:TextStyle(fontWeight:FontWeight.w900)),Text('Articoli seguiti che stanno ricevendo interesse',style:TextStyle(color:Colors.white54,fontSize:11))])),Icon(Icons.chevron_right_rounded,color:MercDealTheme.green)]));
 Widget _showcase(BuildContext context)=>GlassCard(child:Column(children:[Row(children:[const Icon(Icons.workspace_premium_rounded,color:MercDealTheme.gold),const SizedBox(width:8),const Expanded(child:Text('⭐ Vetrina degli annunci Deal+',style:TextStyle(fontSize:18,fontWeight:FontWeight.w900))),TextButton(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const DealPlusScreen())),child:const Text('Vedi tutti'))]),const SizedBox(height:5),_row(context,products.where((x)=>x.showcase).take(2).toList())]));
 Widget _discover(BuildContext context)=>GlassCard(glow:true,child:Row(children:[const Icon(Icons.auto_awesome_rounded,color:MercDealTheme.green),const SizedBox(width:10),const Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('✨ Scopri ora',style:TextStyle(fontSize:19,fontWeight:FontWeight.w900)),Text('Il feed cambia automaticamente ogni 2 minuti.',style:TextStyle(color:Colors.white38,fontSize:10))])),FilledButton(onPressed:()=>setState(()=>tick++),style:FilledButton.styleFrom(backgroundColor:MercDealTheme.green,foregroundColor:Colors.black),child:const Text('🎲'))]));
 Widget _how(BuildContext context)=>GlassCard(onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const HowItWorksScreen())),child:const Row(children:[Icon(Icons.menu_book_rounded,color:MercDealTheme.blue),SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Come funziona MercDeal',style:TextStyle(fontWeight:FontWeight.w900)),Text('Asta al ribasso, acquisto, spedizione e ritiro.',style:TextStyle(color:Colors.white38,fontSize:10))])),Icon(Icons.chevron_right_rounded)]));
}
