import 'package:get/get.dart';

class MarketController extends GetxController {
  // Make showTimeline observable (.obs)
  final showTimeline = true.obs;

  void setShowTimeline(bool value) {
    showTimeline.value = value;
  }
}
