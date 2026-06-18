import 'package:get/get.dart';
import '../../data/candle_data.dart';

class ChartController extends GetxController {
  // null = no candle selected
  final selectedIndex = RxnInt(); // Rxn = nullable Rx

  // your candle data lives here too
  final candles = dummyCandles;

  // ── scroll + zoom state ────────────────
  final scrollOffset = 0.0.obs; // how far scrolled (pixels)
  final candleScale = 1.0.obs; // zoom multiplier

  // ── base candle dimensions ─────────────
  static const double baseCandleWidth = 8.0;
  static const double baseCandleSpacing = 4.0;

  // ── computed from zoom ─────────────────
  double get candleWidth => baseCandleWidth * candleScale.value;
  double get candleSpacing => baseCandleSpacing * candleScale.value;
  double get candleStep => candleWidth + candleSpacing;

  // ── total chart width ──────────────────
  double get totalWidth => candles.length * candleStep;

  // ── scroll handler ─────────────────────
  void onScroll(double delta) {
    final maxScroll = (totalWidth - 300).clamp(0.0, double.infinity);
    scrollOffset.value = (scrollOffset.value - delta).clamp(0.0, maxScroll);
  }

  // ── zoom handler ───────────────────────
  void onZoom(double scaleChange) {
    candleScale.value = (candleScale.value * scaleChange).clamp(0.5, 3.0);
    // 0.5 = zoomed out max, 3.0 = zoomed in max
  }

  // tap handler — called from GestureDetector
  void onCandleTap(double tapX) {
    final adjustedX = tapX + scrollOffset.value;
    final index = (adjustedX / candleStep).floor();
    if (index < 0 || index >= candles.length) {
      selectedIndex.value = null;
      return;
    }
    selectedIndex.value = index;
  }

  // release handler — hide tooltip
  void onCandleRelease() => selectedIndex.value = null;

  // get selected candle data
  CandleData? get selectedCandle {
    final i = selectedIndex.value;
    if (i == null) return null;
    return candles[i];
  }
}
