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
    _drawEMA(canvas, size);
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
        paint..strokeWidth = 1.5,
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
      ..strokeWidth = 1;

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  void _drawEMA(Canvas canvas, Size size) {
    if (emaLines.isEmpty) return;

    // Distinct accent colors for different EMA lines
    final colors = [AppColor.textPrimary];

    for (int lineIndex = 0; lineIndex < emaLines.length; lineIndex++) {
      final emaValues = emaLines[lineIndex];
      if (emaValues.isEmpty) continue;

      final paint = Paint()
        ..color = colors[lineIndex % colors.length]
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;

      final path = Path();
      bool started = false;

      for (int i = 0; i < emaValues.length; i++) {
        if (emaValues[i] == null) continue; // skip nulls at start

        final x = _toX(i);
        final y = _toY(emaValues[i]!, size.height);

        if (!started) {
          path.moveTo(x, y); // first point
          started = true;
        } else {
          path.lineTo(x, y); // connect to next
        }
      }

      canvas.drawPath(path, paint);
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

  // ── Y: cumulative volume → pixel ────────────
  double _toY(double cumVol, double height) {
    // top = max volume, bottom = 0
    return height * (1 - cumVol / maxCumulative) * 0.9 + height * 0.05;
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

  // ── grid ─────────────────────────────────────
  void _drawGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.lightText
      ..strokeWidth = 0.5;

    // horizontal lines
    for (int i = 1; i < 5; i++) {
      final y = size.height * i / 5;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // vertical lines
    for (int i = 1; i < 6; i++) {
      final x = size.width * i / 6;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  // ── BID curve (green, left side) ─────────────
  // ── smooth bid stroke ───────────────────
  void _drawBids(Canvas canvas, Size size) {
    final center = size.width / 2;
    final bids = orderBook.bids;

    final path = Path();
    final strokePath = Path();

    path.moveTo(center, size.height);
    strokePath.moveTo(center, size.height);

    for (int i = 0; i < bids.length; i++) {
      final x = center * (1 - i / bids.length);
      final y = _toY(bidCumulative[i], size.height);

      if (i == 0) {
        path.lineTo(x, y);
        strokePath.lineTo(x, y);
      } else {
        // previous point
        final prevX = center * (1 - (i - 1) / bids.length);
        final prevY = _toY(bidCumulative[i - 1], size.height);

        // control point = midpoint between prev and current
        final cpX = (prevX + x) / 2;
        final cpY = (prevY + y) / 2;

        path.quadraticBezierTo(prevX, prevY, cpX, cpY);
        path.quadraticBezierTo(cpX, cpY, x, y);

        strokePath.quadraticBezierTo(prevX, prevY, cpX, cpY);
        strokePath.quadraticBezierTo(cpX, cpY, x, y);
      }
    }

    path.lineTo(0, size.height);
    path.close();

    // gradient fill
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColor.oderbookGreen, AppColor.oderbookGreenBlur],
        ).createShader(Rect.fromLTWH(0, 0, center, size.height)),
    );

    // stroke
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
    final asks = orderBook.asks;

    final path = Path();
    final strokePath = Path();

    path.moveTo(center, size.height);
    strokePath.moveTo(center, size.height);

    for (int i = 0; i < asks.length; i++) {
      final x = center + center * (i / asks.length);
      final y = _toY(askCumulative[i], size.height);

      if (i == 0) {
        path.lineTo(x, y);
        strokePath.lineTo(x, y);
      } else {
        final prevX = center + center * ((i - 1) / asks.length);
        final prevY = _toY(askCumulative[i - 1], size.height);

        final cpX = (prevX + x) / 2;
        final cpY = (prevY + y) / 2;

        path.quadraticBezierTo(prevX, prevY, cpX, cpY);
        path.quadraticBezierTo(cpX, cpY, x, y);

        strokePath.quadraticBezierTo(prevX, prevY, cpX, cpY);
        strokePath.quadraticBezierTo(cpX, cpY, x, y);
      }
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
    final bids = orderBook.bids;
    final asks = orderBook.asks;

    // Draw green dot on bids (at midpoint of bids curve)
    if (bids.length > 0) {
      final idx = bids.length ~/ 2;
      final x = center * (1 - idx / bids.length);
      final y = _toY(bidCumulative[idx], size.height);
      canvas.drawCircle(
        Offset(x, y),
        5.5,
        Paint()..color = const Color(0xFF00E5FF),
      );
      canvas.drawCircle(Offset(x, y), 3, Paint()..color = Colors.white);
    }

    // Draw red dot on asks (at midpoint of asks curve)
    if (asks.length > 0) {
      final idx = asks.length ~/ 2;
      final x = center + center * (idx / asks.length);
      final y = _toY(askCumulative[idx], size.height);
      canvas.drawCircle(
        Offset(x, y),
        5.5,
        Paint()..color = const Color(0xFFFF0055),
      );
      canvas.drawCircle(Offset(x, y), 3, Paint()..color = Colors.white);
    }
  }

  // ── vertical line + dot on tap ───────────────
  void _drawTooltipLine(Canvas canvas, Size size) {
    final center = size.width / 2;
    final i = selectedIndex!;
    final isBid = selectedSide == 'bid';

    final x = isBid
        ? center * (1 - i / orderBook.bids.length)
        : center + center * (i / orderBook.asks.length);

    final cumVol = isBid ? bidCumulative[i] : askCumulative[i];
    final y = _toY(cumVol, size.height);
    final level = isBid ? orderBook.bids[i] : orderBook.asks[i];

    // ── vertical line (cyan) ─────────────────────
    canvas.drawLine(
      Offset(x, 0),
      Offset(x, size.height),
      Paint()
        ..color = const Color(0xFF00E5FF)
        ..strokeWidth = 1.5,
    );

    // ── dot at intersection (cyan/red outer border, white center) ──
    canvas.drawCircle(
      Offset(x, y),
      5.5,
      Paint()
        ..color = isBid ? const Color(0xFF00E5FF) : const Color(0xFFFF0055)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    canvas.drawCircle(Offset(x, y), 3.5, Paint()..color = Colors.white);

    // ── floating tooltip box ────────────────────
    const boxW = 140.0;
    const boxH = 64.0;
    const radius = Radius.circular(8);

    // Centered horizontally over the vertical line, clamped to screen edges
    double boxX = x - boxW / 2;
    boxX = boxX.clamp(4.0, size.width - boxW - 4.0);

    // Fixed near the top of the chart (aligned with the design)
    const boxY = 8.0;

    // Shadow
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(boxX + 2, boxY + 2, boxW, boxH),
        radius,
      ),
      Paint()..color = Colors.black26,
    );

    // Background (dark blue matching the design image)
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(boxX, boxY, boxW, boxH), radius),
      Paint()..color = AppColor.lightBackground,
    );

    // Subtle border
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(boxX, boxY, boxW, boxH), radius),
      Paint()
        ..color = AppColor.secondary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5,
    );

    // ── Text Elements ───────────────────────────

    // Header Price text (large bold white)
    final headerTp = TextPainter(
      text: TextSpan(
        text: '${level.price.toStringAsFixed(6)} BTC',
        style: const TextStyle(
          color: AppColor.textPrimary,
          fontSize: 11.5,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    headerTp.paint(
      canvas,
      Offset(boxX + (boxW - headerTp.width) / 2, boxY + 8),
    );

    // Amount & Total rows
    void drawRow(String label, String value, double offsetY) {
      final labelTp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: AppColor.textPrimary.withValues(alpha: 0.55),
            fontSize: 9.5,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      labelTp.paint(canvas, Offset(boxX + 12, boxY + offsetY));

      final valueTp = TextPainter(
        text: TextSpan(
          text: value,
          style: const TextStyle(
            color: AppColor.textPrimary,
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      valueTp.paint(
        canvas,
        Offset(boxX + boxW - valueTp.width - 12, boxY + offsetY),
      );
    }

    drawRow('Amount:', '${level.volume.toStringAsFixed(5)} BTC', 28);
    drawRow('Total:', '${cumVol.toStringAsFixed(5)} ETH', 42);
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
