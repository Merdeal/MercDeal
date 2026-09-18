import 'package:flutter_test/flutter_test.dart';
import 'package:mercdeal/app/app.dart';

void main() {
  testWidgets('MercDeal avvia Home e navigazione principale', (tester) async {
    await tester.pumpWidget(const MercDealApp());

    // Attende la fine dello splash e della transizione verso la Home.
    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pumpAndSettle();

    expect(find.text('MercDeal'), findsWidgets);
    expect(find.text('Il prezzo scende. L’affare sale.'), findsWidgets);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Cerca'), findsOneWidget);
    expect(find.text('Vendi'), findsOneWidget);
  });
}
