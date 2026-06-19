import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:maze/tradingDetails/screens/tradingDetails_screen.dart';

void main() {
  testWidgets('TradingdetailsScreen builds and renders without layout exceptions', (WidgetTester tester) async {
    Get.testMode = true;

    // Set a standard portrait screen size to check for overflows
    tester.view.physicalSize = const Size(1080, 2220);
    tester.view.devicePixelRatio = 3.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: TradingdetailsScreen(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify page title renders
    expect(find.byType(TradingdetailsScreen), findsOneWidget);
  });
}
