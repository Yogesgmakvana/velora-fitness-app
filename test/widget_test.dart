import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velora/main.dart';

void main() {
  testWidgets('Velora app smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const VeloraApp());

    // Verify splash screen branding loads
    expect(find.text('VELORA'), findsOneWidget);

    // Fast forward splash timer (2 seconds)
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
  });
}
