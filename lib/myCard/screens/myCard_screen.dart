import 'package:flutter/material.dart';
import 'package:maze/scan/screens/scan_screen.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:maze/home/screens/home_screen.dart';
import 'package:maze/market/screens/market_screen.dart';
import 'package:maze/profile/screens/profile_screen.dart';
import 'package:maze/tradingDetails/screens/tradingDetails_screen.dart';
import 'package:maze/appWidgets/appWidgets.dart';
import 'package:get/get.dart';
import '../widgets/mycard_widgets.dart';

class MyCardScreen extends StatelessWidget {
  const MyCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              CustomScreenHeader(
                title: AppStrings.myCard,
                leading: const Icon(Icons.menu, color: AppColor.textPrimary),
                actions: [
                  IconButton(
                    onPressed: () => Get.to(() => const MyCardScreen()),
                    icon: const Icon(Icons.wallet, color: AppColor.textPrimary),
                  ),
                ],
              ),
              Stack(
                clipBehavior:
                    Clip.none, // allows cards to overflow outside Stack bounds
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 0,
                    child: Transform.rotate(
                      angle: 0.15,
                      alignment: Alignment.topLeft, // rotate from top center
                      child: Container(
                        width: 300, // fixed width, not double.infinity
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color(0xFF0A1A5C),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Transform.translate(
                      offset: const Offset(0, 9), // push down less
                      child: Transform.rotate(
                        angle: 0.05, // ~3.5 degrees right tilt
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 320, // fixed width, not double.infinity
                          height: 200,
                          decoration: BoxDecoration(
                            color: Color(0xFF1230CC),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      width: 340, // fixed width, not double.infinity
                      height: 200,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.cardHolder,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            AppStrings.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(
                                Icons.credit_card,
                                color: AppColor.textPrimary,
                              ),
                              Spacer(),
                              Text(
                                AppStrings.cardNumber,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.textPrimary,
                                  fontSize: 14,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Spacer(),
                              Spacer(),
                              Icon(Icons.circle, color: AppColor.textPrimary),
                            ],
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Spacer(),
                              Text(
                                AppStrings.mastercard,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.textPrimary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),

              Container(
                margin: const EdgeInsets.all(5),
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.surface,
                ),
                child: Text(
                  AppStrings.operations,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColor.textSecondary),
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: List.generate(
                    5,
                    (index) => Row(
                      children: [
                        BalanceRow(title: AppStrings.balanceW),
                        if (index < 4) SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.all(5),
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.surface,
                ),
                child: Text(
                  AppStrings.transactions,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColor.textSecondary),
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.today,
                  style: const TextStyle(
                    color: AppColor.textPrimary,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              Column(
                children: List.generate(
                  5,
                  (index) => Column(
                    children: [
                      TodayRow(
                        name: AppStrings.shopping,
                        date: AppStrings.shoppingTime,
                        amount: AppStrings.shoppingAmount,
                      ),
                      if (index < 4) SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColor.secondary,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home
              IconButton(
                icon: Icon(Icons.home, color: AppColor.textPrimary),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                ),
              ),
              // Wallet
              IconButton(
                icon: Icon(Icons.wallet, color: AppColor.textSecondary),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MarketScreen()),
                ),
              ),

              const SizedBox(width: 56), // gap for FAB notch
              // Market/Chart
              IconButton(
                icon: Icon(
                  Icons.currency_exchange_outlined,
                  color: AppColor.textSecondary,
                ),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TradingdetailsScreen(),
                  ),
                ),
              ),
              // Profile
              IconButton(
                icon: Icon(Icons.person, color: AppColor.textSecondary),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.surface,
          border: Border.all(color: Colors.blue.shade300, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColor.primary.withValues(alpha: 0.5),
              blurRadius: 15,
              spreadRadius: 3,
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(
            Icons.qr_code_scanner_outlined,
            color: Colors.white,
            size: 26,
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ScanScreens()),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
