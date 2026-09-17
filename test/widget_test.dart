import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mercdeal/features/home/home_screen.dart';

void main() {
  testWidgets('MercDeal avvia la Home', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HomeScreen(),
        ),
      ),
    );

    // La Home usa InkWell e richiede un Material/Scaffold sopra di sé.
    await tester.pump();

    expect(find.text('MercDeal'), findsOneWidget);
    expect(find.text('✨ Scopri ora'), findsOneWidget);
  });
}
