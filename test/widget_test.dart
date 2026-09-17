import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mercdeal/features/home/home_screen.dart';

void main() {
  testWidgets('MercDeal V3 Home smoke test', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Material(child: HomeScreen()),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('MercDeal'), findsOneWidget);
    expect(find.text('✨ Scopri ora'), findsOneWidget);
    expect(find.text('ASTA AL RIBASSO'), findsOneWidget);
  });
}
