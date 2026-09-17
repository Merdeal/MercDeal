import 'package:flutter_test/flutter_test.dart';
import 'package:mercdeal/app/app.dart';

void main() {
  testWidgets('MercDeal avvia la Home', (tester) async {
    await tester.pumpWidget(const MercDealApp());

    // La splash resta visibile per 1200 ms prima di aprire la Home.
    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pumpAndSettle();

    expect(find.text('MercDeal'), findsOneWidget);
    expect(find.text('Scopri ora'), findsOneWidget);
  });
}
