import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:maze/market/screens/market_screen.dart';
import 'package:maze/tradingDetails/screens/tradingDetails_screen.dart';
import 'package:maze/profile/screens/profile_screen.dart';
import 'package:get/get.dart';
import '../../myCard/screens/myCard_screen.dart';
import '../../Scan/screens/scan_screen.dart';
import 'package:maze/appWidgets/appWidgets.dart';
import '../widgets/home_widgets.dart';

const List<Map<String, dynamic>> _recentTransactions = [
  {
    'icon': Icons.arrow_upward,
    'title': AppStrings.Received,
    'amount': AppStrings.ReceivedAmount,
    'color': AppColor.textGreen,
  },
  {
    'icon': Icons.arrow_downward,
    'title': AppStrings.Withdrawn,
    'amount': AppStrings.WithdrawnAmount,
    'color': AppColor.textRed,
  },
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(Icons.menu),
      //   title: Text(AppStrings.home, textAlign: TextAlign.center),
      //   actions: [Icon(Icons.wallet)],
      //   backgroundColor: AppColor.primary,
      // ),
      extendBody: true,
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              CustomScreenHeader(
                title: AppStrings.home,
                leading: const Icon(Icons.menu, color: AppColor.textPrimary),
                actions: [
                  IconButton(
                    onPressed: () => Get.to(() => const MyCardScreen()),
                    icon: const Icon(Icons.wallet, color: AppColor.textPrimary),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5, left: 3, right: 3),
                width: double.infinity,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColor.primary,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.qr_code_2_outlined,
                        color: AppColor.textPrimary,
                        size: 24,
                      ),
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
                      ),
                    ),
                    Text(
                      AppStrings.todayChange,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColor.textGreen, fontSize: 12),
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 8, left: 3, right: 3),
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.surface,
                ),
                child: Text(
                  AppStrings.marketStatistics,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColor.textSecondary),
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    MarketStatistics(
                      price: AppStrings.ethereumPrice,
                      name: AppStrings.ethereum,
                      today: AppStrings.ethereumToday,
                      imageUrl: "assets/images/Graph.png",
                      color: AppColor.textGreen,
                    ),
                    SizedBox(width: 20),
                    MarketStatistics(
                      price: AppStrings.bitcoinPrice,
                      name: AppStrings.bitcoin,
                      today: AppStrings.bitcoinToday,
                      imageUrl: "assets/images/Graph2.png",
                      color: AppColor.textRed,
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColor.lightBackground,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppStrings.referRewards,
                        style: TextStyle(
                          color: AppColor.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.referText,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
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
                margin: const EdgeInsets.all(8.0),
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.surface,
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
                      style: TextStyle(color: AppColor.textSecondary),
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
