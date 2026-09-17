import 'package:flutter_test/flutter_test.dart';
import 'package:mercdeal/app/app.dart';

void main() {
  testWidgets('MercDeal avvia la Home', (tester) async {
    await tester.pumpWidget(const MercDealApp());
    expect(find.text('MercDeal'), findsOneWidget);
    expect(find.text('Scopri ora'), findsOneWidget);
  });
}
