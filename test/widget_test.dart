import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfriday_app/app/app.dart';

void main() {
  testWidgets('首頁顯示 flutterFriday', (tester) async {
    await tester.pumpWidget(const FlutterFridayApp());
    expect(find.text('flutterFriday'), findsOneWidget);
    expect(find.text('開始建立'), findsOneWidget);
  });
}
