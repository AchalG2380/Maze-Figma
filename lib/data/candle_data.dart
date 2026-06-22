import 'dart:math' as math;

class CandleData {
  final DateTime date;
  final double open;
  final double close;
  final double high;
  final double low;
  final double volume;

  const CandleData({
    required this.date,
    required this.open,
    required this.close,
    required this.high,
    required this.low,
    required this.volume,
  });

  // green or red?
  bool get isBull => close > open;
}

final List<String> timeframes = [
  '1D',
  '3D',
  '7D',
  '1M',
  '3M',
  '1Y',
  '5Y',
  'Max',
];

final List<CandleData> dummyCandles = _generateDummyCandles(150);

List<CandleData> _generateDummyCandles(int count) {
  final list = <CandleData>[];
  final random = math.Random(1337); // deterministic seed for visual stability

  var date = DateTime(2024, 1, 1);
  var currentPrice = 200.0; // Starting price around 200

  for (int i = 0; i < count; i++) {
    // 1. Base trend wave today vs yesterday (maintains roller-coaster cycles & up-trend)
    final waveToday =
        200.0 +
        (i * 0.3) +
        (math.sin(i / 8.0) * 18.0) +
        (math.sin(i / 3.0) * 5.0);
    final waveYesterday = i > 0
        ? 200.0 +
              ((i - 1) * 0.3) +
              (math.sin((i - 1) / 8.0) * 18.0) +
              (math.sin((i - 1) / 3.0) * 5.0)
        : 200.0;

    var change = waveToday - waveYesterday;

    // 2. Short term random daily noise
    change += (random.nextDouble() - 0.5) * 6.0;

    // 3. 40% chance of a high-volatility breakout/dump (increased frequency and magnitude)
    final roll = random.nextDouble();
    if (roll < 0.20) {
      change +=
          15.0 +
          random.nextDouble() * 15.0; // Big green candle (15 to 30 points)
    } else if (roll < 0.40) {
      change -=
          15.0 + random.nextDouble() * 15.0; // Big red candle (15 to 30 points)
    }

    // 4. Enforce a minimum move of 7.0 points (preserving the direction/sign of the move)
    if (change.abs() < 7.0) {
      final sign = change >= 0 ? 1.0 : -1.0;
      change = sign * (7.0 + random.nextDouble() * 3.0); // 7.0 to 10.0 points
    }

    final open = currentPrice;
    final close = open + change;

    // High and Low wicks (scale with body size for high volatility look)
    final bodySize = (close - open).abs();
    final high =
        math.max(open, close) + random.nextDouble() * (3.0 + bodySize * 0.2);
    final low =
        math.min(open, close) - random.nextDouble() * (3.0 + bodySize * 0.2);

    // Volume bars (highly volatile days have higher trading volume)
    final volume =
        150.0 + random.nextDouble() * 500.0 + (bodySize > 12.0 ? 400.0 : 0.0);

    list.add(
      CandleData(
        date: date,
        open: double.parse(open.toStringAsFixed(2)),
        close: double.parse(close.toStringAsFixed(2)),
        high: double.parse(high.toStringAsFixed(2)),
        low: double.parse(low.toStringAsFixed(2)),
        volume: double.parse(volume.toStringAsFixed(2)),
      ),
    );

    currentPrice = close;
    date = date.add(const Duration(days: 1));
  }

  return list;
}
