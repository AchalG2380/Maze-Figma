import 'dart:math' as math;

// single price level
class OrderLevel {
  final double price;
  final double volume;

  const OrderLevel({required this.price, required this.volume});
}

// full order book
class OrderBookData {
  final List<OrderLevel> bids; // buy orders — sorted high to low
  final List<OrderLevel> asks; // sell orders — sorted low to high

  const OrderBookData({required this.bids, required this.asks});
}

final dummyOrderBook = _generateDummyOrderBook();

OrderBookData _generateDummyOrderBook() {
  final bids = <OrderLevel>[];
  final asks = <OrderLevel>[];

  // Bids go from 20.48 down to ~19.50 (30 steps)
  double bidPrice = 20.48;
  for (int i = 0; i < 30; i++) {
    // sin waves create realistic supply/demand concentration curves
    final wave = (1.0 + math.sin(i / 3.0)) * 120.0;
    final volume = 50.0 + i * 10.0 + wave;
    bids.add(
      OrderLevel(
        price: double.parse(bidPrice.toStringAsFixed(4)),
        volume: double.parse(volume.toStringAsFixed(2)),
      ),
    );
    bidPrice -= 0.03;
  }

  // Asks go from 20.50 up to ~21.48 (30 steps)
  double askPrice = 20.50;
  for (int i = 0; i < 30; i++) {
    final wave = (1.0 + math.sin(i / 3.0)) * 120.0;
    final volume = 50.0 + i * 10.0 + wave;
    asks.add(
      OrderLevel(
        price: double.parse(askPrice.toStringAsFixed(4)),
        volume: double.parse(volume.toStringAsFixed(2)),
      ),
    );
    askPrice += 0.03;
  }

  return OrderBookData(bids: bids, asks: asks);
}

final List<String> orderBookPerframes = ['15%', '25%', '35%', '45%', '55%'];
final List<String> orderBookYaxis = ['1k', '1k', '1k', '1k', '1k'];
