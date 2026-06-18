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

final dummyOrderBook = OrderBookData(
  // bids — highest price first, volume accumulates left→center
  bids: [
    OrderLevel(price: 20.48, volume: 120),
    OrderLevel(price: 20.45, volume: 200),
    OrderLevel(price: 20.40, volume: 150),
    OrderLevel(price: 20.35, volume: 300),
    OrderLevel(price: 20.28, volume: 180),
    OrderLevel(price: 20.20, volume: 250),
    OrderLevel(price: 20.10, volume: 400),
    OrderLevel(price: 19.95, volume: 320),
  ],
  // asks — lowest price first, volume accumulates center→right
  asks: [
    OrderLevel(price: 20.50, volume: 80),
    OrderLevel(price: 20.55, volume: 160),
    OrderLevel(price: 20.62, volume: 200),
    OrderLevel(price: 20.70, volume: 140),
    OrderLevel(price: 20.80, volume: 280),
    OrderLevel(price: 20.92, volume: 220),
    OrderLevel(price: 21.05, volume: 350),
    OrderLevel(price: 21.20, volume: 300),
  ],
);

final List<String> orderBookPerframes = ['15%', '25%', '35%', '45%', '55%'];
