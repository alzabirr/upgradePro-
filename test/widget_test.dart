import 'package:flutter_test/flutter_test.dart';
import 'package:upgrade_flutter_starter_kit/main.dart';

void main() {
  testWidgets('SnapApp build test', (WidgetTester tester) async {
    // Build SnapApp
    await tester.pumpWidget(const SnapApp());
    await tester.pumpAndSettle();

    // Verify main screen element is present
    expect(find.text('Welcome to Starter Kit'), findsOneWidget);
  });
}
