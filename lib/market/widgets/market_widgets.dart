import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/data/order_book_data.dart';
import '../../appWidgets/app_charts.dart';
import '../../data/candle_data.dart';
import '../../charts/controllers/chart_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import '../../charts/controllers/order_book_controller.dart';
import '../../tradingDetails/screens/tradingDetails_screen.dart';

class TimelineWidget extends StatelessWidget {
  final bool showControls;

  const TimelineWidget({super.key, this.showControls = true});

  @override
  Widget build(BuildContext context) {
    // inject controller
    final ctrl = Get.isRegistered<ChartController>()
        ? Get.find<ChartController>()
        : Get.put(ChartController());

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.lightDarkBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    border: Border(
                      right: BorderSide(color: AppColor.textPrimary),
                      left: BorderSide(color: AppColor.textPrimary),
                      bottom: BorderSide(color: AppColor.textPrimary),
                    ),
                  ),
                  height: 400,
                  child: Stack(
                    children: [
                      // grid horizontal lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          10,
                          (_) => Divider(
                            color: AppColor.textBackground,
                            thickness: 1,
                            height: 1,
                          ),
                        ),
                      ),
                      // grid vertical lines
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          10,
                          (_) => VerticalDivider(
                            color: AppColor.textBackground,
                            thickness: 1,
                            width: 1,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          // ── Candle chart (70%) ──────────────
                          Expanded(
                            flex: 7,
                            child: Listener(
                              // ── mouse scroll wheel / trackpad (desktop) ──
                              onPointerSignal: (event) {
                                if (event is PointerScrollEvent) {
                                  if (HardwareKeyboard
                                      .instance
                                      .isControlPressed) {
                                    // Ctrl + scroll = zoom
                                    final zoomFactor = event.scrollDelta.dy > 0
                                        ? 0.95
                                        : 1.05;
                                    ctrl.onZoom(zoomFactor);
                                  } else {
                                    // scroll normally
                                    ctrl.onScroll(-event.scrollDelta.dy);
                                  }
                                }
                              },
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,

                                onScaleStart: (d) => ctrl.onScaleStart(),
                                onScaleEnd: (d) => ctrl.onScaleEnd(),
                                onScaleUpdate: (d) {
                                  if (d.pointerCount > 1) {
                                    ctrl.onScaleUpdate(d.scale, d.pointerCount);
                                  } else {
                                    ctrl.onScroll(d.focalPointDelta.dx);
                                    ctrl.onScaleUpdate(1.0, d.pointerCount);
                                  }
                                },

                                // ── tooltip ─────────────────────────
                                onTapDown: (d) =>
                                    ctrl.onCandleTap(d.localPosition.dx),
                                onTapUp: (_) => ctrl.onCandleRelease(),

                                // Obx rebuilds ONLY this CustomPaint on change
                                child: Obx(
                                  () => SizedBox.expand(
                                    child: CustomPaint(
                                      painter: CandlePainter(
                                        candles: ctrl.candles,
                                        selectedIndex: ctrl
                                            .selectedIndex
                                            .value, // ← reactive
                                        scrollOffset: ctrl.scrollOffset.value,
                                        bullColor: AppColor.high,
                                        bearColor: AppColor.low,
                                        gridColor: const Color(0xFF1C2333),
                                        candleWidth: ctrl.candleWidth,
                                        candleSpacing: ctrl.candleSpacing,
                                        emaLines: [
                                          calculateEMA(dummyCandles, 9),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8), // gap between charts
                          // ── Volume bars (30%) ───────────────
                          Expanded(
                            flex: 3,
                            child: Obx(
                              () => SizedBox.expand(
                                child: CustomPaint(
                                  painter: VolumePainter(
                                    candles: ctrl.candles,
                                    scrollOffset: ctrl
                                        .scrollOffset
                                        .value, // ← pass scroll
                                    bullColor: AppColor.high,
                                    bearColor: AppColor.low,
                                    candleWidth: ctrl
                                        .candleWidth, // must match CandlePainter
                                    candleSpacing: ctrl
                                        .candleSpacing, // must match CandlePainter
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // ── Right: Y-axis labels (fixed 45px, same 400 height) ──
              SizedBox(
                width: 45,
                height: 400,
                child: Obx(() {
                  // ── current price info ──
                  final candles = ctrl.candles;
                  final currentPrice = candles.last.close;
                  final isBull = candles.last.isBull;
                  final badgeColor = isBull ? AppColor.high : AppColor.low;

                  // ── calculate Y position of badge ──
                  // must match CandlePainter._toY logic exactly
                  final double chartHeight = 400;
                  final double candleAreaHeight = chartHeight * 0.7; // 280px

                  final maxPrice = candles
                      .map((c) => c.high)
                      .reduce((a, b) => a > b ? a : b);
                  final minPrice = candles
                      .map((c) => c.low)
                      .reduce((a, b) => a < b ? a : b);
                  final range = maxPrice - minPrice;

                  final double padded = candleAreaHeight * 0.8;
                  final double offsetY = candleAreaHeight * 0.1;
                  final double badgeY =
                      offsetY +
                      padded * (1 - (currentPrice - minPrice) / range);

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // ── Y-axis labels ──
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomPaint(
                          size: const Size(45, 400),
                          painter: YAxisPainter(
                            candles: candles,
                            labelCount: 6,
                            textColor: const Color(0xFF8A8A8A),
                            chartHeightRatio: 0.7,
                          ),
                        ),
                      ),

                      // ── Price badge ──
                      Positioned(
                        top: badgeY - 10, // center badge on the line
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            currentPrice.toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
          if (showControls) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    timeframes.length,
                    (index) => Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColor.surface,
                            border: Border.all(
                              color: AppColor.secondary,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            timeframes[index],
                            style: TextStyle(color: AppColor.textSecondary),
                          ),
                        ),
                        const SizedBox(width: 14),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  OutlinedButton(
                    onPressed: () => Get.to(() => const TradingdetailsScreen()),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColor.textRed),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      "- Sell",
                      style: TextStyle(
                        color: AppColor.sellButton,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => Get.to(() => const TradingdetailsScreen()),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppColor.buyButton,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      padding: WidgetStatePropertyAll(
                        const EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 10,
                        ),
                      ),
                    ),
                    child: Text(
                      "Buy +",
                      style: TextStyle(
                        color: AppColor.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class MarketDepthWidget extends StatelessWidget {
  const MarketDepthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(OrderBookController());

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.lightDarkBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 45,
                height: 250, // ← must match container height
                child: CustomPaint(
                  size: const Size(
                    45,
                    250,
                  ), // ← explicit size so painter renders
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      orderBookYaxis.length,
                      (index) => Text(
                        orderBookYaxis[index],
                        style: TextStyle(
                          color: AppColor.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child:
                    // ── Chart ───────────────────────────────
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final chartWidth = constraints.maxWidth;
                        return SizedBox(
                          height: 250,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTapDown: (d) =>
                                ctrl.onTap(d.localPosition.dx, chartWidth),
                            onHorizontalDragUpdate: (d) =>
                                ctrl.onTap(d.localPosition.dx, chartWidth),
                            child: Obx(
                              () => CustomPaint(
                                size: Size(chartWidth, 300),
                                painter: OrderBookPainter(
                                  orderBook: ctrl.orderBook,
                                  bidCumulative: ctrl.bidCumulative,
                                  askCumulative: ctrl.askCumulative,
                                  maxCumulative: ctrl.maxCumulative,
                                  selectedIndex: ctrl.selectedIndex.value,
                                  selectedSide: ctrl.selectedSide.value,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                orderBookPerframes.length,
                (index) => Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        orderBookPerframes[index],
                        style: TextStyle(color: AppColor.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LatestTradesRow extends StatelessWidget {
  final String amount;
  final String price;
  final Color priceColor;
  final String time;

  const LatestTradesRow({
    super.key,
    required this.amount,
    required this.price,
    required this.priceColor,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(amount, style: TextStyle(color: AppColor.textSecondary)),
          Text(price, style: TextStyle(color: priceColor)),
          Text(time, style: TextStyle(color: AppColor.textSecondary)),
        ],
      ),
    );
  }
}

List<double?> calculateEMA(List<CandleData> candles, int period) {
  final ema = List<double?>.filled(candles.length, null);
  if (candles.length < period) return ema;

  // first EMA = simple average of first N candles
  double sum = 0;
  for (int i = 0; i < period; i++) {
    sum += candles[i].close;
  }
  ema[period - 1] = sum / period;

  // multiplier
  final k = 2.0 / (period + 1);

  // rest of EMAs
  for (int i = period; i < candles.length; i++) {
    ema[i] = (candles[i].close * k) + (ema[i - 1]! * (1 - k));
  }

  return ema; // null = not enough data yet for that index
}
