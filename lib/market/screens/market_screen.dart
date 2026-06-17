import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:maze/home/screens/home_screen.dart';
import 'package:maze/market/widgets/market_widgets.dart';
import 'package:maze/tradingDetails/screens/tradingDetails_screen.dart';
import 'package:get/get.dart';
import 'package:maze/profile/screens/profile_screen.dart';
import 'package:maze/scan/screens/scan_screen.dart';
import '../../myCard/screens/myCard_screen.dart';
import 'package:maze/appWidgets/app_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MarketController extends GetxController {
  // Make showTimeline observable (.obs)
  final showTimeline = true.obs;

  void setShowTimeline(bool value) {
    showTimeline.value = value;
  }
}

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
                    onPressed: () => Get.to(() => const MyCardScreen()),
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

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColor.lightBackground),
                        color: AppColor.lightDarkBackground,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    AppStrings.high,
                                    style: TextStyle(color: AppColor.high),
                                  ),
                                  Text(
                                    AppStrings.highPrice,
                                    style: TextStyle(
                                      color: AppColor.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    AppStrings.low,
                                    style: TextStyle(color: AppColor.low),
                                  ),
                                  Text(
                                    AppStrings.lowPrice,
                                    style: TextStyle(
                                      color: AppColor.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(color: AppColor.textSecondary, thickness: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    AppStrings.volBTC,
                                    style: TextStyle(
                                      color: AppColor.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    AppStrings.highPrice,
                                    style: TextStyle(
                                      color: AppColor.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    AppStrings.volETH,
                                    style: TextStyle(
                                      color: AppColor.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    AppStrings.lowPrice,
                                    style: TextStyle(
                                      color: AppColor.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            AppStrings.price,
                            style: TextStyle(
                              color: AppColor.textPrimary,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            AppStrings.priceChange,
                            style: TextStyle(color: AppColor.textGreen),
                          ),
                          SizedBox(height: 20),
                          DropdownButton(
                            items: [
                              DropdownMenuItem(
                                child: Text(
                                  AppStrings.currency,
                                  style: TextStyle(
                                    color: AppColor.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

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
                              ? AppColor.lightBackground
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
                              ? AppColor.lightBackground
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

              namedCardWidgets(name: AppStrings.latestTrades),

              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      color: AppColor.lightBackground,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.amountBTC,
                          style: TextStyle(color: AppColor.textSecondary),
                        ),
                        Text(
                          AppStrings.priceETH,
                          style: TextStyle(color: AppColor.textSecondary),
                        ),
                        Text(
                          AppStrings.time,
                          style: TextStyle(color: AppColor.textSecondary),
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
      bottomNavigationBar: CustomBottomAppBar(
        currentIndex:
            0, // 0 for Home, 1 for Wallet, 2 for Market, 3 for Profile
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MarketScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const TradingdetailsScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
              break;
          }
        },
      ),
      // Reusable Floating Scanner Button
      floatingActionButton: CustomScanFAB(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ScanScreens()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
