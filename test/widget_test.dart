import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfriday/main.dart';

void main() {
  testWidgets('App loads without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterFridayApp());
    await tester.pumpAndSettle();

    expect(find.text('flutterFriday'), findsAtLeastNWidgets(1));
    expect(find.text('開始創作'), findsWidgets);
  });
}
