import 'package:get/get.dart';
import '../../data/order_book_data.dart';

class OrderBookController extends GetxController {
  final orderBook = dummyOrderBook;

  // selected point on tap
  final selectedSide = Rxn<String>(); // 'bid' or 'ask'
  final selectedIndex = RxnInt();

  // ── compute cumulative volumes ──────────────
  List<double> get bidCumulative {
    double sum = 0;
    return orderBook.bids.map((b) {
      sum += b.volume;
      return sum;
    }).toList();
  }

  List<double> get askCumulative {
    double sum = 0;
    return orderBook.asks.map((a) {
      sum += a.volume;
      return sum;
    }).toList();
  }

  double get maxCumulative {
    final maxBid = bidCumulative.last;
    final maxAsk = askCumulative.last;
    return maxBid > maxAsk ? maxBid : maxAsk;
  }

  // ── tap handler ─────────────────────────────
  void onTap(double tapX, double chartWidth) {
    final center = chartWidth / 2;
    if (tapX < center) {
      // tapped bid side
      final ratio = (center - tapX) / center;
      final index = (ratio * orderBook.bids.length).floor().clamp(
        0,
        orderBook.bids.length - 1,
      );
      selectedSide.value = 'bid';
      selectedIndex.value = index;
    } else {
      // tapped ask side
      final ratio = (tapX - center) / center;
      final index = (ratio * orderBook.asks.length).floor().clamp(
        0,
        orderBook.asks.length - 1,
      );
      selectedSide.value = 'ask';
      selectedIndex.value = index;
    }
  }

  void onRelease() {
    selectedSide.value = null;
    selectedIndex.value = null;
  }

  // selected level data for tooltip
  OrderLevel? get selectedLevel {
    final i = selectedIndex.value;
    if (i == null) return null;
    return selectedSide.value == 'bid' ? orderBook.bids[i] : orderBook.asks[i];
  }

  double? get selectedCumulative {
    final i = selectedIndex.value;
    if (i == null) return null;
    return selectedSide.value == 'bid' ? bidCumulative[i] : askCumulative[i];
  }
}
