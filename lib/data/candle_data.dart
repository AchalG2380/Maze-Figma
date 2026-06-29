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

final List<CandleData> dummyCandles = _generateDummyCandles();

List<CandleData> _generateDummyCandles() {
  final list = <CandleData>[];
  var date = DateTime(2024, 1, 1);

  final List<Map<String, double>> rawData = [
    {'o': 20.35, 'c': 20.39, 'h': 20.45, 'l': 20.34, 'v': 250},
    {'o': 20.32, 'c': 20.40, 'h': 20.47, 'l': 20.31, 'v': 310},
    {'o': 20.51, 'c': 20.48, 'h': 20.53, 'l': 20.33, 'v': 180},
    {'o': 20.32, 'c': 20.35, 'h': 20.46, 'l': 20.29, 'v': 210},
    {'o': 20.38, 'c': 20.27, 'h': 20.42, 'l': 20.26, 'v': 290},
    {'o': 20.38, 'c': 20.42, 'h': 20.44, 'l': 20.22, 'v': 350},
    {'o': 20.27, 'c': 20.19, 'h': 20.34, 'l': 20.26, 'v': 580},
    {'o': 20.20, 'c': 20.26, 'h': 20.28, 'l': 20.13, 'v': 640},
    {'o': 20.13, 'c': 20.09, 'h': 20.26, 'l': 20.07, 'v': 410},
    {'o': 20.18, 'c': 20.28, 'h': 20.37, 'l': 20.11, 'v': 820},
    {'o': 20.08, 'c': 20.14, 'h': 20.17, 'l': 20.06, 'v': 750},
    {'o': 20.10, 'c': 19.96, 'h': 20.13, 'l': 19.92, 'v': 380},
    {'o': 19.97, 'c': 19.93, 'h': 20.01, 'l': 19.90, 'v': 920},
    {'o': 19.94, 'c': 19.92, 'h': 19.97, 'l': 19.89, 'v': 290},
    {'o': 19.94, 'c': 19.97, 'h': 19.99, 'l': 19.89, 'v': 460},
    {'o': 19.98, 'c': 20.03, 'h': 20.04, 'l': 19.90, 'v': 510},
    {'o': 19.95, 'c': 20.06, 'h': 20.08, 'l': 19.92, 'v': 490},
    {'o': 20.13, 'c': 20.04, 'h': 20.16, 'l': 20.01, 'v': 330},
    {'o': 20.16, 'c': 20.09, 'h': 20.19, 'l': 20.06, 'v': 620},
    {'o': 20.11, 'c': 20.18, 'h': 20.22, 'l': 20.09, 'v': 410},

    {'o': 20.14, 'c': 20.34, 'h': 20.38, 'l': 20.10, 'v': 580},
    {'o': 20.17, 'c': 20.09, 'h': 20.21, 'l': 20.05, 'v': 810},
    {'o': 20.18, 'c': 20.27, 'h': 20.29, 'l': 20.07, 'v': 340},
    {'o': 20.34, 'c': 20.25, 'h': 20.41, 'l': 20.21, 'v': 290},
    {'o': 20.17, 'c': 20.29, 'h': 20.39, 'l': 20.13, 'v': 890},
    {'o': 20.24, 'c': 20.39, 'h': 20.45, 'l': 20.20, 'v': 950},
    {'o': 20.43, 'c': 20.39, 'h': 20.47, 'l': 20.36, 'v': 420},
    {'o': 20.37, 'c': 20.30, 'h': 20.43, 'l': 20.27, 'v': 310},
    {'o': 20.34, 'c': 20.30, 'h': 20.43, 'l': 20.27, 'v': 260},
    {'o': 20.37, 'c': 20.34, 'h': 20.39, 'l': 20.27, 'v': 380},
    {'o': 20.24, 'c': 20.29, 'h': 20.31, 'l': 20.22, 'v': 450},

    {'o': 20.35, 'c': 20.39, 'h': 20.45, 'l': 20.34, 'v': 250},
    {'o': 20.32, 'c': 20.40, 'h': 20.47, 'l': 20.31, 'v': 310},
    {'o': 20.51, 'c': 20.48, 'h': 20.53, 'l': 20.33, 'v': 180},
    {'o': 20.50, 'c': 20.60, 'h': 20.70, 'l': 20.30, 'v': 250},
    {'o': 20.55, 'c': 20.61, 'h': 20.63, 'l': 20.54, 'v': 310},
    {'o': 20.52, 'c': 20.43, 'h': 20.58, 'l': 20.40, 'v': 180},
    {'o': 20.32, 'c': 20.35, 'h': 20.46, 'l': 20.29, 'v': 210},
    {'o': 20.38, 'c': 20.27, 'h': 20.42, 'l': 20.26, 'v': 290},
    {'o': 20.38, 'c': 20.42, 'h': 20.44, 'l': 20.22, 'v': 350},
    {'o': 20.27, 'c': 20.19, 'h': 20.34, 'l': 20.26, 'v': 580},
    {'o': 20.20, 'c': 20.26, 'h': 20.28, 'l': 20.13, 'v': 640},
    {'o': 20.13, 'c': 20.09, 'h': 20.26, 'l': 20.07, 'v': 410},
    {'o': 20.18, 'c': 20.28, 'h': 20.37, 'l': 20.11, 'v': 820},
    {'o': 20.08, 'c': 20.14, 'h': 20.17, 'l': 20.06, 'v': 750},
    {'o': 20.10, 'c': 19.96, 'h': 20.13, 'l': 19.92, 'v': 380},
    {'o': 19.97, 'c': 19.93, 'h': 20.01, 'l': 19.90, 'v': 920},
    {'o': 19.94, 'c': 19.92, 'h': 19.97, 'l': 19.89, 'v': 290},
    {'o': 19.94, 'c': 19.97, 'h': 19.99, 'l': 19.89, 'v': 460},
    {'o': 19.98, 'c': 20.03, 'h': 20.04, 'l': 19.90, 'v': 510},
    {'o': 19.95, 'c': 20.06, 'h': 20.08, 'l': 19.92, 'v': 490},
    {'o': 20.13, 'c': 20.04, 'h': 20.16, 'l': 20.01, 'v': 330},
    {'o': 20.16, 'c': 20.09, 'h': 20.19, 'l': 20.06, 'v': 620},
    {'o': 20.11, 'c': 20.18, 'h': 20.22, 'l': 20.09, 'v': 410},

    // 31: Green (last candle is green!)
    {'o': 20.24, 'c': 20.26, 'h': 20.31, 'l': 20.22, 'v': 450},
  ];

  for (int i = 0; i < rawData.length; i++) {
    final data = rawData[i % rawData.length];

    // Slight multiplier/offset is no longer needed since count is exactly 31,
    // but we can preserve the line to keep code structure simple and generic.
    final double offset = (i ~/ rawData.length) * 0.0;

    list.add(
      CandleData(
        date: date,
        open: double.parse((data['o']! + offset).toStringAsFixed(2)),
        close: double.parse((data['c']! + offset).toStringAsFixed(2)),
        high: double.parse((data['h']! + offset).toStringAsFixed(2)),
        low: double.parse((data['l']! + offset).toStringAsFixed(2)),
        volume: data['v']!,
      ),
    );
    date = date.add(const Duration(days: 1));
  }

  return list;
}
