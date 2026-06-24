import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:get/get.dart';
import 'package:maze/appWidgets/app_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../market/widgets/market_widgets.dart';
import '../widgets/tradingDetails_widgets.dart';
import '../controllers/trading_details_controller.dart';
import '../../data/candle_data.dart';
import '../../news/screens/news_screen.dart';

class TradingdetailsScreen extends StatelessWidget {
  const TradingdetailsScreen({super.key});

  Widget _buildPriceRow({
    required String price,
    required String amount,
    required Color priceColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              price,
              style: TextStyle(color: priceColor, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            amount,
            style: const TextStyle(color: AppColor.textSecondary, fontSize: 12),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String label,
    required TradingTab tab,
    required TradingDetailsController controller,
  }) {
    return Obx(() {
      final isSelected = controller.activeTab.value == tab;
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => controller.selectTab(tab),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppColor.primary : AppColor.textSecondary,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColor.primary : Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TradingDetailsController());
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomScreenHeader(
                title: AppStrings.tradingDetails,
                leading: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/menu.svg',
                    colorFilter: ColorFilter.mode(
                      AppColor.textPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () => Get.to(() => const NewsScreen()),
                    icon: SvgPicture.asset(
                      'assets/icons/notification.svg',
                      colorFilter: ColorFilter.mode(
                        AppColor.textPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),

              Container(padding: EdgeInsets.all(12), child: TradeHeader()),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: const EdgeInsets.only(
                        right: 8,
                        top: 8,
                        bottom: 8,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              right: 8,
                              top: 8,
                              bottom: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(12),
                              ),
                              color: AppColor.lightBackground4,
                            ),
                            child: Transform.translate(
                              offset: const Offset(-20, 0),
                              child: Column(
                                children: [
                                  const TimelineWidget(showControls: false),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 5,
                                      right: 30,
                                    ),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                          timeframes.length,
                                          (index) => Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(
                                                  3,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: AppColor
                                                      .lightBackground
                                                      .withValues(alpha: .8),
                                                ),
                                                child: Text(
                                                  timeframes[index],
                                                  style: TextStyle(
                                                    color:
                                                        AppColor.textSecondary,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 14),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.primary,
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            "H1",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.primary,
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: SvgPicture.asset(
                                            "assets/icons/Vector.svg",
                                            height: 14,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.primary,
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: SvgPicture.asset(
                                            "assets/icons/Bolt.svg",
                                            height: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildTabButton(
                                label: AppStrings.open,
                                tab: TradingTab.open,
                                controller: controller,
                              ),
                              _buildTabButton(
                                label: AppStrings.filled,
                                tab: TradingTab.filled,
                                controller: controller,
                              ),
                              _buildTabButton(
                                label: AppStrings.cancelled,
                                tab: TradingTab.cancelled,
                                controller: controller,
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),
                          Obx(() {
                            switch (controller.activeTab.value) {
                              case TradingTab.open:
                              case TradingTab.filled:
                              case TradingTab.cancelled:
                                return const PricingCard();
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 4,
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              AppStrings.orderBook,
                              style: TextStyle(
                                color: AppColor.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...List.generate(
                            6,
                            (_) => _buildPriceRow(
                              price: AppStrings.orderBookPrice,
                              amount: AppStrings.orderBookPrice,
                              priceColor: AppColor.textGreen,
                            ),
                          ),
                          ...List.generate(
                            6,
                            (_) => _buildPriceRow(
                              price: AppStrings.orderBookPrice,
                              amount: AppStrings.orderBookPrice,
                              priceColor: AppColor.textRed,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Center(
                            child: Text(
                              AppStrings.trades,
                              style: TextStyle(
                                color: AppColor.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...List.generate(
                            6,
                            (_) => _buildPriceRow(
                              price: AppStrings.orderBookPrice,
                              amount: AppStrings.orderBookPrice,
                              priceColor: AppColor.textGreen,
                            ),
                          ),
                          ...List.generate(
                            6,
                            (_) => _buildPriceRow(
                              price: AppStrings.orderBookPrice,
                              amount: AppStrings.orderBookPrice,
                              priceColor: AppColor.textRed,
                            ),
                          ),
                          const SizedBox(height: 22),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Reusable Notch Bottom App Bar
      bottomNavigationBar: CustomBottomAppBar(),
      // Reusable Floating Scanner Button
      floatingActionButton: CustomScanFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
