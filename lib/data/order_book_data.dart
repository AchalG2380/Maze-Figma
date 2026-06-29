class OrderLevel {
  final double price;
  final double volume;
  const OrderLevel({required this.price, required this.volume});
}

class OrderBookData {
  final List<OrderLevel> bids;
  final List<OrderLevel> asks;
  const OrderBookData({required this.bids, required this.asks});
}

// ✅ Predefined — 10 levels each, irregular volumes
final dummyOrderBook = OrderBookData(
  bids: [
    OrderLevel(price: 20.48, volume: 2.1), // closest to mid — thin
    OrderLevel(price: 20.45, volume: 3.4),
    OrderLevel(price: 20.39, volume: 4.8),
    OrderLevel(price: 20.36, volume: 8.1),
    OrderLevel(price: 20.33, volume: 6.5),
    OrderLevel(price: 20.30, volume: 12.3),
    OrderLevel(price: 20.27, volume: 18.7),
    OrderLevel(price: 20.24, volume: 28.4),
    OrderLevel(price: 20.21, volume: 45.0), // farthest — deepest
  ],
  asks: [
    OrderLevel(price: 20.50, volume: 1.8), // closest to mid — thin
    OrderLevel(price: 20.53, volume: 4.1),
    OrderLevel(price: 20.56, volume: 3.9),
    OrderLevel(price: 20.42, volume: 5.2),
    OrderLevel(price: 20.59, volume: 6.7),
    OrderLevel(price: 20.62, volume: 5.3),
    OrderLevel(price: 20.65, volume: 9.2),
    OrderLevel(price: 20.68, volume: 14.6),
    OrderLevel(price: 20.71, volume: 22.1),
    OrderLevel(price: 20.74, volume: 35.8),
    OrderLevel(price: 20.77, volume: 52.0), // farthest — deepest
  ],
);

final List<String> orderBookPerframes = ['15%', '25%', '35%', '45%', '55%'];
final List<String> orderBookYaxis = [
  '1k',
  '1k',
  '1k',
  '1k',
  '1k',
  '1k',
  '1k',
  '1k',
  '1k',
];
