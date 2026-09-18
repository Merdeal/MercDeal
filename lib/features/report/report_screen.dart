import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';

class ReportScreen extends StatefulWidget { const ReportScreen({super.key}); @override State<ReportScreen> createState()=>_ReportScreenState(); }
class _ReportScreenState extends State<ReportScreen>{ bool fraud=false;
 @override Widget build(BuildContext context){
  final evidence=['Ordine e importo','Annuncio e utenti coinvolti','Date e orari','Chat rilevante','Pagamento','Tracking e spedizione','Video imballaggio / apertura','Peso del pacco','Security Seal','Altre prove e allegati'];
  return Scaffold(appBar:AppBar(title:const Text('MercDeal Report',style:TextStyle(fontWeight:FontWeight.w900))),body:ListView(padding:const EdgeInsets.all(16),children:[
   const Text('🚨 Segnala un problema',style:TextStyle(fontSize:26,fontWeight:FontWeight.w900)),const SizedBox(height:6),const Text('In caso di possibile truffa, MercDeal può raccogliere le evidenze pertinenti all’ordine.',style:TextStyle(color:Colors.white54)),
   SwitchListTile(contentPadding:EdgeInsets.zero,value:fraud,onChanged:(v)=>setState(()=>fraud=v),title:const Text('Possibile truffa',style:TextStyle(fontWeight:FontWeight.w900))),
   ...evidence.map((x)=>const ListTile(leading:Icon(Icons.check_circle_outline,color:MercDealTheme.green),title:Text(''))).toList().asMap().entries.map((e)=>ListTile(leading:const Icon(Icons.check_circle_outline,color:MercDealTheme.green),title:Text(evidence[e.key]))),
   const SizedBox(height:8),const GlassCard(child:Text('Il report è un riepilogo di evidenze. L’utente deve controllarlo e decidere se procedere verso la procedura ufficiale di denuncia.',style:TextStyle(color:Colors.white60,fontSize:11,height:1.4))),const SizedBox(height:12),
   GlowButton(label:'Prepara riepilogo',icon:Icons.description_outlined,onPressed:()=>showDialog(context:context,builder:(_)=>AlertDialog(title:const Text('Riepilogo pronto'),content:const Text('Demo: qui il riepilogo verrebbe mostrato per il controllo finale prima di qualsiasi procedura ufficiale.'),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Chiudi'))])))
  ]));
 }
}
