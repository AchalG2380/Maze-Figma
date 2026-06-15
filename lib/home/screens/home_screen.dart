import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:maze/market/screen/market_screen.dart';
import 'package:maze/tradingDetails/screen/tradingDetails_screen.dart';
import 'package:maze/profile/screens/profile_screen.dart';
import 'package:get/get.dart';

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
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu, color: AppColor.textPrimary),
                    Center(
                      child: Text(
                        AppStrings.home,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.textPrimary,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Icon(Icons.wallet, color: AppColor.textPrimary),
                  ],
                ),
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
                        Icons.qr_code,
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
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: 14, left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.lightDarkBackground,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.circle, color: Colors.white),
                                SizedBox(width: 50),
                                Text(
                                  AppStrings.ethereumPrice,
                                  style: TextStyle(color: AppColor.textPrimary),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                AppStrings.ethereum,
                                style: TextStyle(color: AppColor.textSecondary),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                AppStrings.ethereumToday,
                                style: TextStyle(color: AppColor.textGreen),
                              ),
                            ),
                            Center(
                              child: Image.asset('assets/images/Graph.png'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: 14, left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.lightDarkBackground,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.circle, color: Colors.white),
                                SizedBox(width: 50),
                                Text(
                                  AppStrings.bitcoinPrice,
                                  style: TextStyle(color: AppColor.textPrimary),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                AppStrings.bitcoin,
                                style: TextStyle(color: AppColor.textSecondary),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                AppStrings.bitcoinToday,
                                style: TextStyle(color: AppColor.textRed),
                              ),
                            ),
                            Center(
                              child: Image.asset('assets/images/Graph2.png'),
                            ),
                          ],
                        ),
                      ),
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
                  Container(
                    margin: const EdgeInsets.all(3.0),
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.lightDarkBackground,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_upward, color: AppColor.textGreen),
                        Text(
                          AppStrings.Received,
                          style: TextStyle(color: AppColor.textPrimary),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            AppStrings.ReceivedAmount,
                            style: TextStyle(color: AppColor.textGreen),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(3.0),
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.lightDarkBackground,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_downward, color: AppColor.textRed),
                        Text(
                          AppStrings.Withdrawn,
                          style: TextStyle(color: AppColor.textPrimary),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            AppStrings.WithdrawnAmount,
                            style: TextStyle(color: AppColor.textRed),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.secondary,
        unselectedItemColor: AppColor.textSecondary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange),
            label: 'Exchange',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (value) {
          switch (value) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TradingdetailsScreen(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MarketScreen()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}
