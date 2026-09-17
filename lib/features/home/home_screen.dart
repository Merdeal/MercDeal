import 'dart:async';
import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
import '../../models/listing.dart';
import '../listing/listing_detail_screen.dart';
import '../notifications/notifications_screen.dart';
import '../how_it_works/how_it_works_screen.dart';
import '../deal_plus/deal_plus_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  int tick = 0;

  final products = const <Listing>[
    Listing(id:'1',title:'Sony Alpha 7 III',category:'Fotografia',price:1179.80,startPrice:1240,minimumPrice:1090,drop:.20,followers:18,icon:Icons.camera_alt_rounded,mode:SaleMode.descendingAuction,condition:ListingCondition.excellent,verifiedSeller:true,inShowcase:true,location:'Roma'),
    Listing(id:'2',title:'PlayStation 5 Slim',category:'Gaming',price:454.80,startPrice:520,minimumPrice:420,drop:.20,followers:34,icon:Icons.sports_esports_rounded,mode:SaleMode.descendingAuction,condition:ListingCondition.excellent,verifiedSeller:true,inShowcase:false,location:'Milano'),
    Listing(id:'3',title:'Air Jordan Retro',category:'Moda',price:128.80,startPrice:160,minimumPrice:110,drop:.20,followers:27,icon:Icons.shopping_bag_rounded,mode:SaleMode.descendingAuction,condition:ListingCondition.newItem,verifiedSeller:true,inShowcase:true,location:'Torino'),
    Listing(id:'4',title:'iPad Air',category:'Elettronica',price:399.80,startPrice:450,minimumPrice:350,drop:.20,followers:41,icon:Icons.tablet_mac_rounded,mode:SaleMode.descendingAuction,condition:ListingCondition.good,verifiedSeller:true,inShowcase:false,location:'Bologna'),
  ];

  @override void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(minutes: 2), (_) {
      if (mounted) setState(() => tick++);
    });
  }
  @override void dispose() { timer?.cancel(); super.dispose(); }

  void open(BuildContext c, Widget page) => Navigator.push(c, MaterialPageRoute(builder: (_) => page));

  @override Widget build(BuildContext c) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async => setState(() => tick++),
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 32),
          children: [
            Row(children: [
              Container(width:44,height:44,decoration:BoxDecoration(gradient:const LinearGradient(colors:[MercDealTheme.green,MercDealTheme.blue]),borderRadius:BorderRadius.circular(14)),child:const Icon(Icons.shopping_cart_rounded,color:Color(0xFF04120B))),
              const SizedBox(width:10),
              const Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('MercDeal',style:TextStyle(fontSize:25,fontWeight:FontWeight.w900)),Text('SCONTI CHE VIVONO',style:TextStyle(color:MercDealTheme.green,fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1.5))])),
              IconButton(onPressed:()=>open(c,const NotificationsScreen()),icon:const Icon(Icons.notifications_none_rounded)),
            ]),
            const SizedBox(height:16),
            TextField(readOnly:true,onTap:()=>ScaffoldMessenger.of(c).showSnackBar(const SnackBar(content:Text('Usa Cerca dalla barra inferiore'))),decoration:const InputDecoration(hintText:'Cerca il tuo prossimo affare...',prefixIcon:Icon(Icons.search_rounded),suffixIcon:Icon(Icons.mic_none_rounded))),
            const SizedBox(height:14),
            SizedBox(height:40,child:ListView.separated(scrollDirection:Axis.horizontal,itemCount:5,separatorBuilder:(_,__)=>const SizedBox(width:8),itemBuilder:(_,i){final labels=['🔥 Tutto','Elettronica','Gaming','Moda','Casa'];final icons=[Icons.local_fire_department,Icons.devices,Icons.sports_esports,Icons.checkroom,Icons.home_outlined];return Chip(label:Text(labels[i]),avatar:Icon(icons[i],size:17,color:MercDealTheme.green));})),
            const SizedBox(height:14),
            GlassCard(glow:true,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('ASTA AL RIBASSO',style:TextStyle(color:MercDealTheme.green,fontWeight:FontWeight.w900,letterSpacing:1.3)),const SizedBox(height:6),const Text('Il prezzo scende.\nL’affare sale.',style:TextStyle(fontSize:29,fontWeight:FontWeight.w900,height:1.02)),const SizedBox(height:9),const Text('€0,20 in meno ogni giorno · 7 / 15 / 30 giorni',style:TextStyle(color:Color(0xB3FFFFFF))),const SizedBox(height:14),Row(children:[Expanded(child:LinearProgressIndicator(value:.68,minHeight:8,borderRadius:BorderRadius.all(Radius.circular(10)),color:MercDealTheme.green,backgroundColor:Colors.white10)),const SizedBox(width:12),const Text('−68%',style:TextStyle(color:MercDealTheme.green,fontWeight:FontWeight.w900))])])),
            const SizedBox(height:24),
            SectionHeader(title:'✨ Scopri ora',action:'🎲 Cambia',onAction:()=>setState(()=>tick++)),
            const SizedBox(height:10),
            SizedBox(height:245,child:ListView.separated(scrollDirection:Axis.horizontal,itemCount:products.length,separatorBuilder:(_,__)=>const SizedBox(width:10),itemBuilder:(_,i){final p=products[(i+tick)%products.length];return DealCard(title:p.title,price:'€${p.price.toStringAsFixed(2).replaceAll('.',',')}',subtitle:'↓ €0,20 oggi · ${p.followers} seguono',icon:p.icon,featured:p.inShowcase,following:i.isEven,onTap:()=>open(c,ListingDetailScreen(listing:p)));})),
            const SizedBox(height:24),
            const SectionHeader(title:'🔥 Sta scendendo ora'),
            const SizedBox(height:10),
            GlassCard(child:Column(children:[_drop('PlayStation 5 Slim','€454,80','€520,00','−12,5%'),_drop('iPad Air','€399,80','€450,00','−11,2%'),_drop('Air Jordan Retro','€128,80','€160,00','−19,5%')])),
            const SizedBox(height:24),
            const SectionHeader(title:'⚡ Quasi al tuo prezzo'),
            const SizedBox(height:10),
            GlassCard(child:Column(children:[const Row(children:[Icon(Icons.track_changes,color:MercDealTheme.green),SizedBox(width:10),Expanded(child:Text('PlayStation 5 Slim',style:TextStyle(fontWeight:FontWeight.w900))),Text('€454,80',style:TextStyle(fontWeight:FontWeight.w900))]),const SizedBox(height:8),LinearProgressIndicator(value:.86,minHeight:7,borderRadius:BorderRadius.all(Radius.circular(8)),color:MercDealTheme.blue,backgroundColor:Colors.white10),const SizedBox(height:7),const Text('Obiettivo €450,00 · quasi raggiunto',style:TextStyle(color:Colors.white54,fontSize:12))])),
            const SizedBox(height:24),
            const SectionHeader(title:'💎 Vetrina Deal+'),
            const SizedBox(height:10),
            DealCard(title:'Sony Alpha 7 III',price:'€1.179,80',subtitle:'💎 7 giorni in Vetrina',icon:Icons.camera_alt_rounded,featured:true,onTap:()=>open(c,const DealPlusScreen())),
            const SizedBox(height:24),
            GlassCard(onTap:()=>open(c,const HowItWorksScreen()),child:const Row(children:[Icon(Icons.auto_awesome_rounded,color:MercDealTheme.green,size:30),SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Come funziona MercDeal',style:TextStyle(fontWeight:FontWeight.w900)),Text('Scopri in 60 secondi come comprare, vendere e seguire un prezzo.',style:TextStyle(color:Colors.white54,fontSize:12))])),Icon(Icons.arrow_forward_ios_rounded,size:16,color:Colors.white38)])),
          ],
        ),
      ),
    );
  }

  Widget _drop(String title,String price,String old,String pct) => Padding(padding:const EdgeInsets.symmetric(vertical:8),child:Row(children:[Container(width:42,height:42,decoration:BoxDecoration(color:MercDealTheme.card2,borderRadius:BorderRadius.circular(13)),child:const Icon(Icons.trending_down_rounded,color:MercDealTheme.green)),const SizedBox(width:10),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontWeight:FontWeight.w800)),Text('$old  →  $pct',style:const TextStyle(color:Colors.white38,fontSize:11))])),Text(price,style:const TextStyle(fontWeight:FontWeight.w900))]));
}
