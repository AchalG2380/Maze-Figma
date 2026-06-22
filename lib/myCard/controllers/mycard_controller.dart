import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCardController extends GetxController {
  final scrollController = ScrollController();
  final activeIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final offset = scrollController.offset;
      if (maxScroll <= 0) return;
      
      // Calculate fraction of scroll covered, mapped to 3 indicators (indices 0, 1, 2)
      final fraction = (offset / maxScroll).clamp(0.0, 1.0);
      final index = (fraction * 2).round();
      
      if (activeIndex.value != index) {
        activeIndex.value = index;
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
