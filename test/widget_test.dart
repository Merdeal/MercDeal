import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mercdeal/app/app.dart';
void main(){
  testWidgets('MercDeal avvia Home e navigazione principale',(tester) async{
    await tester.pumpWidget(const MercDealApp());
    await tester.pump(const Duration(milliseconds:1200));
    expect(find.text('MercDeal'), findsWidgets);
    expect(find.text('Il prezzo scende. L’affare sale.'), findsWidgets);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Cerca'), findsOneWidget);
    expect(find.text('Vendi'), findsOneWidget);
  });
}
