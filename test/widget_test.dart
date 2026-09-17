import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mercdeal/features/home/home_screen.dart';

void main() {
  testWidgets('MercDeal Home smoke test', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Material(
            child: HomeScreen(),
          ),
        ),
      ),
    );

    expect(find.text('MercDeal'), findsWidgets);
    expect(find.text('✨ Scopri ora'), findsOneWidget);
  });
}
