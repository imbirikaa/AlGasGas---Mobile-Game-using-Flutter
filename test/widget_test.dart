import 'package:flutter_test/flutter_test.dart';

import 'package:barra_modo3/main.dart';

void main() {
  testWidgets('App launches to the load screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('لعبة من القصقاص ؟'), findsOneWidget);
    expect(find.text('ابدأ اللعبة'), findsOneWidget);
  });
}
