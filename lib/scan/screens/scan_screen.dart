import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:maze/home/screens/home_screen.dart';
import 'package:maze/market/screens/market_screen.dart';
import 'package:maze/profile/screens/profile_screen.dart';
import 'package:maze/tradingDetails/screens/tradingDetails_screen.dart';
import '../../myCard/screens/myCard_screen.dart';
import 'package:get/get.dart';
import 'package:maze/appWidgets/app_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScanScreens extends StatelessWidget {
  const ScanScreens({super.key});

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
                title: AppStrings.scan,
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

              SizedBox(height: 50),

              Text(
                AppStrings.scanInfo,
                style: TextStyle(color: AppColor.textPrimary, fontSize: 14),
              ),

              SizedBox(height: 100),

              Image.asset("assets/images/QRCodeScan.png", height: 200),

              SizedBox(height: 30),

              Text(
                AppStrings.scanStart,
                style: TextStyle(color: AppColor.textPrimary, fontSize: 12),
              ),

              SizedBox(height: 100),

              ElevatedButton(
                onPressed: () => Get.to(() => const HomeScreen()),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  backgroundColor: AppColor.button2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: AppColor.textSecondary),
                ),
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
