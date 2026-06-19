import 'package:get/get.dart';

enum TradingTab { open, filled, cancelled }

class TradingDetailsController extends GetxController {
  final activeTab = TradingTab.open.obs;

  void selectTab(TradingTab tab) {
    activeTab.value = tab;
  }
}
