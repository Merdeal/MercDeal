import 'package:flutter/material.dart';

class MercDealTheme {
  static const green=Color(0xFF43FF8A), blue=Color(0xFF3CA8FF), navy=Color(0xFF050A12), surface=Color(0xFF08131F), card=Color(0xFF0C1B2A), card2=Color(0xFF11273A);
  static ThemeData dark(){
    final cs=ColorScheme.fromSeed(seedColor:green,brightness:Brightness.dark).copyWith(primary:green,secondary:blue,surface:surface);
    return ThemeData(useMaterial3:true,brightness:Brightness.dark,scaffoldBackgroundColor:navy,colorScheme:cs,fontFamily:'Roboto',
      appBarTheme:const AppBarTheme(backgroundColor:Colors.transparent,elevation:0),
      navigationBarTheme:NavigationBarThemeData(backgroundColor:Color(0xFF07111C),indicatorColor:Color(0x2943FF8A),height:72,
        labelTextStyle:WidgetStateProperty.resolveWith((s)=>TextStyle(fontSize:11,fontWeight:s.contains(WidgetState.selected)?FontWeight.w900:FontWeight.w600,color:s.contains(WidgetState.selected)?green:Color(0x8AFFFFFF)))),
      inputDecorationTheme:InputDecorationTheme(filled:true,fillColor:card,hintStyle:const TextStyle(color:Color(0x61FFFFFF)),border:OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(18)),borderSide:BorderSide.none),enabledBorder:OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(18)),borderSide:BorderSide(color:Color(0x12FFFFFF))),focusedBorder:OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(18)),borderSide:const BorderSide(color:green))));
  }
}
