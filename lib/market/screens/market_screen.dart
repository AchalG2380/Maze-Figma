import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:maze/market/widgets/market_widgets.dart';
import 'package:get/get.dart';
import 'package:maze/appWidgets/app_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/market_controller.dart';
import '../../news/screens/news_screen.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MarketController());
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              CustomScreenHeader(
                title: AppStrings.exchangeMarket,
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

              TradeHeader(),

              Obx(() {
                final showTimeline = controller.showTimeline.value;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () => controller.setShowTimeline(true),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          showTimeline
                              ? AppColor.secondary
                              : AppColor.lightDarkBackground,
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/Timeline.svg'),
                          const SizedBox(width: 10),
                          Text(
                            AppStrings.timeline,
                            style: TextStyle(
                              color: showTimeline
                                  ? AppColor.textPrimary
                                  : AppColor.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => controller.setShowTimeline(false),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          !showTimeline
                              ? AppColor.secondary
                              : AppColor.lightDarkBackground,
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/book.svg'),
                          const SizedBox(width: 10),
                          Text(
                            AppStrings.marketDepth,
                            style: TextStyle(
                              color: !showTimeline
                                  ? AppColor.textPrimary
                                  : AppColor.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                );
              }),
              SizedBox(height: 10),
              Obx(
                () => controller.showTimeline.value
                    ? const TimelineWidget()
                    : const MarketDepthWidget(),
              ),

              NamedCardWidgets(name: AppStrings.latestTrades),

              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      color: AppColor.secondary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.amountBTC,
                          style: TextStyle(color: AppColor.textPrimary),
                        ),
                        Text(
                          AppStrings.priceETH,
                          style: TextStyle(color: AppColor.textPrimary),
                        ),
                        Text(
                          AppStrings.time,
                          style: TextStyle(color: AppColor.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                      color: AppColor.lightDarkBackground,
                      border: Border.all(color: AppColor.primary, width: .5),
                    ),
                    child: Column(
                      children: List.generate(
                        5,
                        (index) => LatestTradesRow(
                          amount: AppStrings.amountBTCtext,
                          price: AppStrings.priceETHtext,
                          icon: (index < 2)
                              ? SvgPicture.asset("assets/icons/Up_right.svg")
                              : SvgPicture.asset("assets/icons/Down_right.svg"),
                          priceColor: (index < 2)
                              ? AppColor.textGreen
                              : AppColor.textRed,
                          time: AppStrings.timetext,
                        ),
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
