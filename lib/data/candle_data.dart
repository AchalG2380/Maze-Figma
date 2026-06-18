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
    // 1. Overall gradual upward trend drift
    final drift = i * 0.25;

    // 2. Sinusoidal waves for roller-coaster ups and downs (peaks/valleys)
    final cycle = math.sin(i / 10.0) * 15.0 + math.sin(i / 3.0) * 4.0;

    // 3. Short term random daily noise
    final noise = (random.nextDouble() - 0.5) * 3.0;

    final open = currentPrice;
    final close = 200.0 + drift + cycle + noise;

    // High and Low wicks
    final high = math.max(open, close) + random.nextDouble() * 2.5;
    final low = math.min(open, close) - random.nextDouble() * 2.5;

    // Volume bars
    final volume = 150.0 + random.nextDouble() * 600.0;

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
