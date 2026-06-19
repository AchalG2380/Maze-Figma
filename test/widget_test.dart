import 'package:flutter_test/flutter_test.dart';

import 'package:maze/main.dart';

void main() {
  testWidgets('App splash screen loads', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for the splash screen duration (3 seconds) to complete navigation and animation
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verify that our app starts successfully.
    expect(find.byType(MyApp), findsOneWidget);
  });
}
