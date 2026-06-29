import 'package:flutter/material.dart';
import '../data/candle_data.dart';
import '../data/order_book_data.dart';
import '../core/app_color.dart';

class CandlePainter extends CustomPainter {
  final List<CandleData> candles;
  final int? selectedIndex;
  final double scrollOffset;

  // ── colors ─────────────────────────
  final Color bullColor; // green
  final Color bearColor; // red
  final Color wickColor;
  final Color gridColor;

  // ── layout ─────────────────────────
  final double candleWidth;
  final double candleSpacing;

  final List<List<double?>> emaLines;

  double get currentPrice => candles.last.close;
  bool get isCurrentBull => candles.last.isBull;
  double currentPriceYRatio(double height) {
    return _toY(currentPrice, height) / height;
  }

  CandlePainter({
    required this.candles,
    this.selectedIndex,
    this.scrollOffset = 0,
    this.bullColor = AppColor.textGreen,
    this.bearColor = AppColor.textRed,
    this.wickColor = AppColor.textPrimary,
    this.gridColor = AppColor.lightDarkBackground,
    this.candleWidth = 8,
    this.candleSpacing = 4,
    this.emaLines = const [],
  });

  // ── price range across all candles ─
  double get _maxPrice =>
      candles.map((c) => c.high).reduce((a, b) => a > b ? a : b);

  double get _minPrice =>
      candles.map((c) => c.low).reduce((a, b) => a < b ? a : b);

  // ── converts price → Y pixel ───────
  double _toY(double price, double height) {
    final range = _maxPrice - _minPrice;
    // 10% padding top and bottom
    final padded = height * 0.8;
    final offsetY = height * 0.1;
    return offsetY + padded * (1 - (price - _minPrice) / range);
  }

  // ── converts index → X pixel ───────
  double _toX(int index) {
    return index * (candleWidth + candleSpacing) +
        candleWidth / 2 -
        scrollOffset;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawGrid(canvas, size);
    _drawCandles(canvas, size);
    _drawCurves(canvas, size);
    _drawCurrentPriceLine(canvas, size);
    if (selectedIndex != null) {
      _drawHighlightLine(canvas, size);
      _drawTooltip(canvas, size);
    }
  }

  // ── Vertical highlight line on selected candle ──────────
  void _drawHighlightLine(Canvas canvas, Size size) {
    final x = _toX(selectedIndex!);
    canvas.drawLine(
      Offset(x, 0),
      Offset(x, size.height),
      Paint()
        ..color = AppColor.textPrimary
        ..strokeWidth = 1,
    );
  }

  // ── Tooltip box ─────────────────────────────────────────
  void _drawTooltip(Canvas canvas, Size size) {
    final candle = candles[selectedIndex!];
    final x = _toX(selectedIndex!);

    // tooltip content
    final lines = [
      'O: ${candle.open.toStringAsFixed(2)}',
      'H: ${candle.high.toStringAsFixed(2)}',
      'L: ${candle.low.toStringAsFixed(2)}',
      'C: ${candle.close.toStringAsFixed(2)}',
    ];

    const padding = 8.0;
    const lineHeight = 16.0;
    const boxWidth = 90.0;
    final boxHeight = lines.length * lineHeight + padding * 2;

    // flip to left side if candle is on right half of chart
    final boxX = x > size.width / 2 ? x - boxWidth - 12 : x + 12;
    const boxY = 10.0;

    // draw background box
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(boxX, boxY, boxWidth, boxHeight),
        const Radius.circular(6),
      ),
      Paint()..color = AppColor.lightDarkBackground,
    );

    // draw border
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(boxX, boxY, boxWidth, boxHeight),
        const Radius.circular(6),
      ),
      Paint()
        ..color = AppColor.textBackground
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5,
    );

    // draw each OHLC line
    for (int i = 0; i < lines.length; i++) {
      final tp = TextPainter(
        text: TextSpan(
          text: lines[i],
          style: const TextStyle(color: AppColor.textPrimary, fontSize: 11),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      tp.paint(canvas, Offset(boxX + padding, boxY + padding + i * lineHeight));
    }
  }

  // ── Grid lines ─────────────────────
  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5;

    // 5 horizontal lines
    for (int i = 0; i <= 5; i++) {
      final y = size.height * i / 5;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // vertical lines per candle
    for (int i = 0; i < candles.length; i++) {
      final x = _toX(i);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  // ── Draw all candles ───────────────
  void _drawCandles(Canvas canvas, Size size) {
    for (int i = 0; i < candles.length; i++) {
      final candle = candles[i];
      final x = _toX(i);
      final color = candle.isBull ? bullColor : bearColor;

      final paint = Paint()..color = color;

      // skip candles outside visible area
      if (x < -candleWidth) continue;
      if (x > size.width + candleWidth) continue;

      // 1. Draw wick (thin — high to low)
      canvas.drawLine(
        Offset(x, _toY(candle.high, size.height)),
        Offset(x, _toY(candle.low, size.height)),
        paint..strokeWidth = 0.7,
      );

      // 2. Draw body (thick — open to close)
      final bodyTop = _toY(
        candle.isBull ? candle.close : candle.open,
        size.height,
      );
      final bodyBottom = _toY(
        candle.isBull ? candle.open : candle.close,
        size.height,
      );

      canvas.drawRect(
        Rect.fromLTRB(
          x - candleWidth / 2, // left
          bodyTop, // top
          x + candleWidth / 2, // right
          bodyBottom, // bottom
        ),
        paint..strokeWidth = 0,
      );
    }
  }

  void _drawCurrentPriceLine(Canvas canvas, Size size) {
    final currentPrice = candles.last.close;
    final isBull = candles.last.isBull;
    final y = _toY(currentPrice, size.height);

    final paint = Paint()
      ..color = isBull ? AppColor.textGreen : AppColor.textRed
      ..strokeWidth = .5;

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  void _drawCurves(Canvas canvas, Size size) {
    final curveColor = AppColor.chartLine.withValues(alpha: .8);

    final linePaint = Paint()
      ..color = curveColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()
      ..color = AppColor.chartLine.withValues(alpha: .8)
      ..style = PaintingStyle.fill;

    // 1. Diagonal Line (bottom-left to top-right, perfectly straight!)
    final startY = size.height * 0.75;
    final endY = size.height * 0.10;

    canvas.drawLine(Offset(0, startY), Offset(size.width, endY), linePaint);

    // Draw dots at start and end
    canvas.drawCircle(Offset(0, startY), 4.5, dotPaint);
    canvas.drawCircle(Offset(size.width, endY), 4.5, dotPaint);

    // 2. Wavy Solid Curve (refined fixed path matching image)
    final wavyPath = Path();
    wavyPath.moveTo(0, size.height * 0.28);
    wavyPath.cubicTo(
      size.width * 0.20,
      size.height * 0.22,
      size.width * 0.30,
      size.height * 0.75,
      size.width * 0.45,
      size.height * 0.75,
    );
    wavyPath.cubicTo(
      size.width * 0.55,
      size.height * 0.75,
      size.width * 0.65,
      size.height * 0.28,
      size.width * 0.72,
      size.height * 0.28,
    );
    wavyPath.cubicTo(
      size.width * 0.80,
      size.height * 0.28,
      size.width * 0.88,
      size.height * 0.70,
      size.width * 0.92,
      size.height * 0.70,
    );
    wavyPath.cubicTo(
      size.width * 0.96,
      size.height * 0.70,
      size.width * 0.98,
      size.height * 0.58,
      size.width,
      size.height * 0.58,
    );
    canvas.drawPath(wavyPath, linePaint);

    // 3. Wavy Dotted Curve (refined fixed path matching image)
    final dottedPath = Path();
    dottedPath.moveTo(0, size.height * 0.38);
    dottedPath.cubicTo(
      size.width * 0.15,
      size.height * 0.38,
      size.width * 0.25,
      size.height * 0.55,
      size.width * 0.32,
      size.height * 0.55,
    );
    dottedPath.cubicTo(
      size.width * 0.38,
      size.height * 0.55,
      size.width * 0.45,
      size.height * 0.42,
      size.width * 0.52,
      size.height * 0.42,
    );
    dottedPath.cubicTo(
      size.width * 0.62,
      size.height * 0.42,
      size.width * 0.75,
      size.height * 0.65,
      size.width * 0.82,
      size.height * 0.65,
    );
    dottedPath.cubicTo(
      size.width * 0.90,
      size.height * 0.65,
      size.width * 0.95,
      size.height * 0.55,
      size.width,
      size.height * 0.55,
    );

    // Draw dashed path using path metrics
    for (final metric in dottedPath.computeMetrics()) {
      double distance = 0.0;
      const dashLength = 3.0;
      const spaceLength = 3.0;
      while (distance < metric.length) {
        final extract = metric.extractPath(distance, distance + dashLength);
        canvas.drawPath(extract, linePaint);
        distance += dashLength + spaceLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CandlePainter old) =>
      old.candles != candles ||
      old.selectedIndex != selectedIndex ||
      old.scrollOffset != scrollOffset ||
      old.candleWidth != candleWidth;
}

class VolumePainter extends CustomPainter {
  final List<CandleData> candles;
  final double scrollOffset;
  final Color bullColor;
  final Color bearColor;
  final double candleWidth;
  final double candleSpacing;

  VolumePainter({
    required this.candles,
    this.scrollOffset = 0,
    this.bullColor = AppColor.greenBar,
    this.bearColor = AppColor.redBar,
    this.candleWidth = 8,
    this.candleSpacing = 4,
  });

  // max volume across all candles
  double get _maxVolume =>
      candles.map((c) => c.volume).reduce((a, b) => a > b ? a : b);

  // same X logic as CandlePainter
  double _toX(int index) =>
      index * (candleWidth + candleSpacing) + candleWidth / 2 - scrollOffset;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < candles.length; i++) {
      final candle = candles[i];
      final x = _toX(i);
      if (x < -candleWidth) continue;
      final color = candle.isBull ? bullColor : bearColor;

      // how tall is this bar? (proportional to max volume)
      final barHeight = (candle.volume / _maxVolume) * size.height;

      canvas.drawRect(
        Rect.fromLTRB(
          x - candleWidth / 2, // left
          size.height - barHeight, // top (grows upward)
          x + candleWidth / 2, // right
          size.height, // bottom
        ),
        Paint()..color = color.withValues(alpha: 0.2), //transparent
      );
    }
  }

  @override
  bool shouldRepaint(covariant VolumePainter old) =>
      old.candles != candles ||
      old.scrollOffset != scrollOffset ||
      old.candleWidth != candleWidth;
}

class YAxisPainter extends CustomPainter {
  final List<CandleData> candles;
  final int labelCount;
  final Color textColor;
  final double chartHeightRatio;

  YAxisPainter({
    required this.candles,
    this.labelCount = 6,
    this.textColor = AppColor.lightText,
    this.chartHeightRatio = 0.7,
  });

  double get _maxPrice =>
      candles.map((c) => c.high).reduce((a, b) => a > b ? a : b);

  double get _minPrice =>
      candles.map((c) => c.low).reduce((a, b) => a < b ? a : b);

  // ── must match CandlePainter._toY exactly ──
  double _toY(double price, double height) {
    final range = _maxPrice - _minPrice;
    final padded = height * 0.8;
    final offsetY = height * 0.1;
    return offsetY + padded * (1 - (price - _minPrice) / range);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // only use the candle portion of the height
    final candleHeight = size.height * chartHeightRatio;
    final range = _maxPrice - _minPrice;

    for (int i = 0; i <= labelCount; i++) {
      final price = _minPrice + (range * i / labelCount);
      final y = _toY(price, candleHeight); // ← use candleHeight

      final tp = TextPainter(
        text: TextSpan(
          text: price.toStringAsFixed(2),
          style: TextStyle(color: textColor, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      tp.paint(canvas, Offset(0, y - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant YAxisPainter old) => old.candles != candles;
}

class OrderBookPainter extends CustomPainter {
  final OrderBookData orderBook;
  final List<double> bidCumulative;
  final List<double> askCumulative;
  final double maxCumulative;
  final int? selectedIndex;
  final String? selectedSide;

  OrderBookPainter({
    required this.orderBook,
    required this.bidCumulative,
    required this.askCumulative,
    required this.maxCumulative,
    this.selectedIndex,
    this.selectedSide,
  });

  // Smooth spline control points matching the reference image curve shape
  static const bidsY = [
    0.88,
    0.85,
    0.80,
    0.78,
    0.68,
    0.58,
    0.55,
    0.54,
    0.43,
    0.42,
  ];
  static const asksY = [
    0.88,
    0.82,
    0.76,
    0.74,
    0.68,
    0.60,
    0.55,
    0.54,
    0.44,
    0.42,
  ];

  // Hermite Spline Interpolation for smooth, organic chart curves
  double _interpolateY(double t, List<double> yValues) {
    final double indexDouble = t * (yValues.length - 1);
    final int index = indexDouble.floor().clamp(0, yValues.length - 2);
    final double fraction = indexDouble - index;

    final double p0 = yValues[index == 0 ? 0 : index - 1];
    final double p1 = yValues[index];
    final double p2 = yValues[index + 1];
    final double p3 = index + 2 >= yValues.length
        ? yValues.length - 1
        : index + 2;

    final double t2 = fraction * fraction;
    final double t3 = t2 * fraction;

    final double h00 = 2 * t3 - 3 * t2 + 1;
    final double h10 = t3 - 2 * t2 + fraction;
    final double h01 = -2 * t3 + 3 * t2;
    final double h11 = t3 - t2;

    final double m0 = (p2 - p0) / 2.0;
    final double m1 = (yValues[p3.toInt()] - p1) / 2.0;

    return h00 * p1 + h10 * m0 + h01 * p2 + h11 * m1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawGrid(canvas, size);
    _drawBids(canvas, size);
    _drawAsks(canvas, size);
    _drawHighlightDots(canvas, size);
    if (selectedIndex != null) {
      _drawTooltipLine(canvas, size);
    }
  }

  // ── grid matching design layout (9 lines) ─────────────────
  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.lightText
      ..strokeWidth = 0.5;

    // horizontal lines
    for (int i = 0; i <= 8; i++) {
      final y = size.height * i / 8;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // vertical lines
    for (int i = 1; i < 10; i++) {
      final x = size.width * i / 9;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  // ── BID curve (green, left side) ─────────────
  void _drawBids(Canvas canvas, Size size) {
    final center = size.width / 2;

    final path = Path();
    final strokePath = Path();

    path.moveTo(center, size.height);
    path.lineTo(center, size.height * bidsY.first);
    strokePath.moveTo(center, size.height * bidsY.first);

    const steps = 40;
    for (int i = 1; i <= steps; i++) {
      final t = i / steps;
      final x = center * (1 - t);
      final y = size.height * _interpolateY(t, bidsY);

      path.lineTo(x, y);
      strokePath.lineTo(x, y);
    }

    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColor.oderbookGreen, AppColor.oderbookGreenBlur],
        ).createShader(Rect.fromLTWH(0, 0, center, size.height)),
    );

    canvas.drawPath(
      strokePath,
      Paint()
        ..color = AppColor.oderbookGreen
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );
  }

  // ── ASK curve (red, right side) ──────────────
  void _drawAsks(Canvas canvas, Size size) {
    final center = size.width / 2;

    final path = Path();
    final strokePath = Path();

    path.moveTo(center, size.height);
    path.lineTo(center, size.height * asksY.first);
    strokePath.moveTo(center, size.height * asksY.first);

    const steps = 40;
    for (int i = 1; i <= steps; i++) {
      final t = i / steps;
      final x = center + center * t;
      final y = size.height * _interpolateY(t, asksY);

      path.lineTo(x, y);
      strokePath.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColor.oderbookRed, AppColor.oderbookRedBlur],
        ).createShader(Rect.fromLTWH(center, 0, center, size.height)),
    );

    canvas.drawPath(
      strokePath,
      Paint()
        ..color = AppColor.oderbookRed
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );
  }

  void _drawHighlightDots(Canvas canvas, Size size) {
    final center = size.width / 2;

    // Bid dot — at t = 0.6 (shoulder point matching 20% on the screen)
    final bidX = center * (1 - 0.6);
    final bidY = size.height * _interpolateY(0.6, bidsY);
    canvas.drawCircle(
      Offset(bidX, bidY),
      5.5,
      Paint()..color = const Color(0xFF00E5FF),
    );
    canvas.drawCircle(Offset(bidX, bidY), 3.0, Paint()..color = Colors.white);

    // Ask dot — at t = 0.6 (shoulder point matching 50% on the screen)
    final askX = center + center * 0.6;
    final askY = size.height * _interpolateY(0.6, asksY);
    canvas.drawCircle(
      Offset(askX, askY),
      5.5,
      Paint()..color = const Color(0xFFFF0055),
    );
    canvas.drawCircle(Offset(askX, askY), 3.0, Paint()..color = Colors.white);
  }

  // ── vertical line + dot on tap ───────────────
  void _drawTooltipLine(Canvas canvas, Size size) {
    final center = size.width / 2;
    final i = selectedIndex!;
    final isBid = selectedSide == 'bid';

    final t = i / (isBid ? orderBook.bids.length : orderBook.asks.length);
    final x = isBid ? center * (1 - t) : center + center * t;
    final y = size.height * _interpolateY(t, isBid ? bidsY : asksY);
    final level = isBid ? orderBook.bids[i] : orderBook.asks[i];
    final cumVol = isBid ? bidCumulative[i] : askCumulative[i];

    // ── vertical line (cyan) ─────────────────────
    canvas.drawLine(
      Offset(x, y),
      Offset(x, 48), // connects to bottom center of tooltip
      Paint()
        ..color = const Color(0xFF00E5FF).withOpacity(0.8)
        ..strokeWidth = 1.5,
    );

    // ── dot at intersection (cyan/red outer border, white center) ──
    canvas.drawCircle(
      Offset(x, y),
      6.0,
      Paint()
        ..color = isBid ? const Color(0xFF00E5FF) : const Color(0xFFFF0055)
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(Offset(x, y), 3.0, Paint()..color = Colors.white);

    // ── floating tooltip box (matching design exactly!) ──
    const boxW = 150.0;
    const boxH = 75.0;
    const radius = Radius.circular(8);

    double boxX = x - boxW / 2;
    boxX = boxX.clamp(4.0, size.width - boxW - 4.0);

    const boxY = 8.0;

    // Background (dark navy, semi-transparent)
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(boxX, boxY, boxW, boxH), radius),
      Paint()..color = AppColor.primary.withOpacity(0.3),
    );

    // Subtle border
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(boxX, boxY, boxW, boxH), radius),
      Paint()
        ..color = const Color(0xFF00E5FF).withOpacity(0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // Header Price text (large bold white)
    final headerTp = TextPainter(
      text: TextSpan(
        text: '${level.price.toStringAsFixed(8)} BTC',
        style: const TextStyle(
          color: AppColor.lightText,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    headerTp.paint(canvas, Offset(boxX + 12, boxY + 10));

    // Amount & Total rows
    void drawRow(String label, String value, double offsetY) {
      final labelTp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(color: AppColor.lightText, fontSize: 10.0),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      labelTp.paint(canvas, Offset(boxX + 12, boxY + offsetY));

      final valueTp = TextPainter(
        text: TextSpan(
          text: value,
          style: const TextStyle(
            color: AppColor.lightText,
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      valueTp.paint(
        canvas,
        Offset(boxX + boxW - valueTp.width - 12, boxY + offsetY),
      );
    }

    drawRow('Amount:', '${level.volume.toStringAsFixed(5)} BTC', 32);
    drawRow('Total:', '${cumVol.toStringAsFixed(5)} ETH', 50);
  }

  @override
  bool shouldRepaint(covariant OrderBookPainter old) =>
      old.selectedIndex != selectedIndex || old.selectedSide != selectedSide;
}

class AreaChartPainter extends CustomPainter {
  final List<double> dataPoints;
  final Color lineColor;
  final Color gradientTop;
  final Color gradientBottom;

  AreaChartPainter({
    required this.dataPoints,
    required this.lineColor,
    required this.gradientTop,
    required this.gradientBottom,
  });

  double _toX(int index, double width) =>
      width * index / (dataPoints.length - 1);

  double _toY(double value, double height) {
    final max = dataPoints.reduce((a, b) => a > b ? a : b);
    final min = dataPoints.reduce((a, b) => a < b ? a : b);
    return height * 0.1 + (height * 0.4) * (1 - (value - min) / (max - min));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final fillPath = Path();
    final strokePath = Path();

    // start bottom left
    fillPath.moveTo(0, size.height);
    fillPath.lineTo(0, _toY(dataPoints[0], size.height));
    strokePath.moveTo(0, _toY(dataPoints[0], size.height));

    for (int i = 1; i < dataPoints.length; i++) {
      final x = _toX(i, size.width);
      final y = _toY(dataPoints[i], size.height);
      final prevX = _toX(i - 1, size.width);
      final prevY = _toY(dataPoints[i - 1], size.height);

      // smooth curve using cubic bezier
      final cpX1 = prevX + (x - prevX) / 2;
      final cpX2 = prevX + (x - prevX) / 2;

      fillPath.cubicTo(cpX1, prevY, cpX2, y, x, y);
      strokePath.cubicTo(cpX1, prevY, cpX2, y, x, y);
    }

    // close fill to bottom
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    // gradient fill
    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [gradientTop, gradientBottom],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    // stroke line on top
    canvas.drawPath(
      strokePath,
      Paint()
        ..color = lineColor
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant AreaChartPainter old) =>
      old.dataPoints != dataPoints;
}
