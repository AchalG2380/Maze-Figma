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
import 'package:flutter_svg/flutter_svg.dart';

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
                          SizedBox(height: 30),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/Credit card chip.svg',
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
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Spacer(),
                              Spacer(),
                              Image.asset(
                                "assets/images/cardlogo.png",
                                height: 25,
                                width: 40,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.credit_card_outlined,
                                    color: AppColor.textPrimary,
                                    size: 24,
                                  );
                                },
                              ),
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

              namedCardWidgets(name: AppStrings.operations),

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

              namedCardWidgets(name: AppStrings.transactions),

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
      bottomNavigationBar: CustomBottomAppBar(
        currentIndex: 0,
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
