import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:get/get.dart';
import 'package:maze/appWidgets/app_widgets.dart';
import '../widgets/home_widgets.dart';
import '../../news/screens/news_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/area_chart_data.dart';

final List<Map<String, dynamic>> _recentTransactions = [
  {
    'icon': SvgPicture.asset(
      "assets/icons/Polygon 1.svg",
      width: 10,
      colorFilter: ColorFilter.mode(AppColor.textGreen, BlendMode.srcIn),
    ),
    'title': AppStrings.Received,
    'titleDate': AppStrings.ReceivedDate,
    'amount': AppStrings.ReceivedAmount,
    'color': AppColor.textGreen,
  },
  {
    'icon': SvgPicture.asset(
      "assets/icons/Polygon 2.svg",
      width: 10,
      colorFilter: ColorFilter.mode(AppColor.textRed, BlendMode.srcIn),
    ),
    'title': AppStrings.Withdrawn,
    'titleDate': AppStrings.WithdrawnDate,
    'amount': AppStrings.WithdrawnAmount,
    'color': AppColor.textRed,
  },
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              CustomScreenHeader(
                title: AppStrings.home,
                leading: IconButton(
                  onPressed: () => Get.to(() => const NewsScreen()),
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
              Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                width: double.infinity,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColor.textBackground,
                ),
                child: Text(
                  AppStrings.liveMarkets,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColor.textPrimary),
                ),
              ),

              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColor.primary,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: SvgPicture.asset("assets/icons/QR.svg"),
                    ),

                    Text(
                      AppStrings.TPB,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.textPrimary,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      AppStrings.balance,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                      ),
                    ),
                    Text(
                      AppStrings.todayChange,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.high,
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                        height: 2.0,
                      ),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),

              NamedCardWidgets(name: AppStrings.marketStatistics),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    MarketStatistics(
                      price: AppStrings.price,
                      coin: AppStrings.eth,
                      name: AppStrings.ethereum,
                      today: AppStrings.ethereumToday,
                      logoUrl: "assets/images/ETH.png",
                      color: AppColor.high,
                      arrow: SvgPicture.asset("assets/icons/Polygon 1.svg"),
                      dataPoints: area_chart_dataPoints
                          .where((element) => element.containsKey('Green'))
                          .first['Green']!,
                    ),
                    SizedBox(width: 20),
                    MarketStatistics(
                      price: AppStrings.price,
                      coin: AppStrings.btc,
                      name: AppStrings.bitcoin,
                      today: AppStrings.bitcoinToday,
                      logoUrl: "assets/images/bth.png",
                      color: AppColor.low,
                      arrow: SvgPicture.asset("assets/icons/Polygon 2.svg"),
                      dataPoints: area_chart_dataPoints
                          .where((element) => element.containsKey('Red'))
                          .first['Red']!,
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(8),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColor.secondary,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppStrings.referRewards,
                        style: TextStyle(
                          color: AppColor.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.referText,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColor.textPrimary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.button,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          AppStrings.referButton,
                          style: TextStyle(color: AppColor.textPrimary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(
                  top: 14,
                  bottom: 14,
                  left: 8,
                  right: 8,
                ),
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.lightBackground3,
                ),
                child: Row(
                  children: [
                    Text(
                      AppStrings.recentTransactions,
                      style: TextStyle(color: AppColor.textPrimary),
                    ),
                    Spacer(),
                    Text(
                      AppStrings.seeMore,
                      style: TextStyle(
                        color: AppColor.textSecondary,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  ..._recentTransactions
                      .map(
                        (items) => RecentTransactions(
                          icon: items['icon'],
                          title: items['title'],
                          titleDate: items['titleDate'],
                          amount: items['amount'],
                          color: items['color'],
                        ),
                      )
                      .toList(),
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
