import 'package:flutter_test/flutter_test.dart';

import 'package:garment_ecommerce/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const GarmentEcommerceApp());
    expect(find.byType(GarmentEcommerceApp), findsOneWidget);
  });
}
