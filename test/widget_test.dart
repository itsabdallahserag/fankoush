import 'package:fankoush/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FankoushApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FankoushApp());
    expect(find.byType(FankoushApp), findsOneWidget);

    // Advance timer to avoid pending timer in test
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
  });
}
