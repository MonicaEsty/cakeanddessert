import 'package:flutter_test/flutter_test.dart';

import 'package:cakeanddessert/main.dart';

void main() {
  testWidgets('MILKY Bakery home screen loads', (tester) async {
    await tester.pumpWidget(const CakeDessertApp());

    expect(find.text('MILKY Bakery'), findsOneWidget);
    expect(find.text('Sweet Moments\nStart Here'), findsOneWidget);
    expect(find.text('Lihat Katalog'), findsOneWidget);
    expect(find.text('Lihat Promo'), findsOneWidget);
  });
}