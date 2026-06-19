import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:maze/market/widgets/market_widgets.dart';
import 'package:maze/data/candle_data.dart';
import 'package:maze/charts/controllers/chart_controller.dart';

void main() {
  testWidgets('TimelineWidget builds and paints without exceptions', (WidgetTester tester) async {
    // Suppress GetX warnings/errors during test if any
    Get.testMode = true;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TimelineWidget(),
        ),
      ),
    );

    // Let the widget render
    await tester.pumpAndSettle();

    // Verify it built successfully
    expect(find.byType(TimelineWidget), findsOneWidget);
  });

  testWidgets('MarketDepthWidget builds and paints without exceptions', (WidgetTester tester) async {
    Get.testMode = true;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MarketDepthWidget(),
        ),
      ),
    );

    // Let the widget render
    await tester.pumpAndSettle();

    // Verify it built successfully
    expect(find.byType(MarketDepthWidget), findsOneWidget);
  });

  test('dummyCandles satisfy minimum move and big candle density requirements', () {
    final candles = dummyCandles;
    int countLessThan7 = 0;
    int bigCandlesCount = 0;

    for (int i = 0; i < candles.length; i++) {
      final c = candles[i];
      final move = (c.close - c.open).abs();
      if (move < 7.0) {
        countLessThan7++;
      }
      if (move >= 15.0) {
        bigCandlesCount++;
      }
    }

    final bigCandleRatio = bigCandlesCount / candles.length;
    print('Total dummy candles: ${candles.length}');
    print('Candles with move < 7.0: $countLessThan7');
    print('Big candles (move >= 15.0): $bigCandlesCount (${(bigCandleRatio * 100).toStringAsFixed(1)}%)');

    expect(countLessThan7, 0, reason: 'All candles must have a move of at least 7.0 points.');
    expect(bigCandleRatio, greaterThanOrEqualTo(0.35), reason: 'At least 35% of candles should be big candles (>= 15.0 points move).');
  });

  test('ChartController handles pinch-to-zoom correctly', () {
    final ctrl = Get.put(ChartController());
    ctrl.candleScale.value = 1.0;

    // Simulate scale start
    ctrl.onScaleStart();

    // Simulate multi-touch zoom to 1.5x
    ctrl.onScaleUpdate(1.5, 2);
    expect(ctrl.candleScale.value, 1.5);

    // Simulate transition: lift fingers, touch again at 1.5x
    ctrl.onScaleEnd();
    ctrl.onScaleStart();

    // Simulate zooming down by 0.5x
    ctrl.onScaleUpdate(0.5, 2);
    expect(ctrl.candleScale.value, 0.75); // 1.5 * 0.5 = 0.75
  });
}
