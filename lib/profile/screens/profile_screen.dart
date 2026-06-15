import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:maze/home/screens/home_screen.dart';
import 'package:maze/market/screen/market_screen.dart';
import 'package:maze/tradingDetails/screen/tradingDetails_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Icon(Icons.arrow_back_ios, color: AppColor.textPrimary),
                    Center(
                      child: Text(
                        AppStrings.profile,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.textPrimary,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Icon(Icons.settings_outlined, color: AppColor.textPrimary),
                  ],
                ),
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColor.primary, AppColor.secondary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(color: AppColor.textGreen, spreadRadius: 2),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/profile.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColor.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              Text(
                AppStrings.name,
                style: TextStyle(color: AppColor.textPrimary, fontSize: 18),
              ),
              Text(
                AppStrings.ID,
                style: TextStyle(color: AppColor.textSecondary, fontSize: 16),
              ),
              SizedBox(height: 20),

              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColor.lightDarkBackground,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.person_2, color: AppColor.textSecondary),
                        SizedBox(width: 20),
                        Text(
                          AppStrings.edit,
                          style: TextStyle(color: AppColor.textSecondary),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColor.lightDarkBackground,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lock_open, color: AppColor.textSecondary),
                        SizedBox(width: 20),
                        Text(
                          AppStrings.editPass,
                          style: TextStyle(color: AppColor.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColor.lightDarkBackground,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.money, color: AppColor.textSecondary),
                        SizedBox(width: 20),
                        Text(
                          AppStrings.currencyW,
                          style: TextStyle(color: AppColor.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColor.lightDarkBackground,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shield_outlined,
                          color: AppColor.textSecondary,
                        ),
                        SizedBox(width: 20),
                        Text(
                          AppStrings.twoFactorAuthentication,
                          style: TextStyle(color: AppColor.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.notifications,
                  style: TextStyle(color: AppColor.textPrimary, fontSize: 18),
                ),
              ),
              SizedBox(height: 8),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColor.lightDarkBackground,
                    ),
                    child: Row(
                      children: [
                        Text(
                          AppStrings.faceID,
                          style: TextStyle(color: AppColor.textSecondary),
                        ),
                        Spacer(),
                        Switch(value: false, onChanged: (value) {}),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColor.lightDarkBackground,
                    ),
                    child: Row(
                      children: [
                        Text(
                          AppStrings.notificationSett,
                          style: TextStyle(color: AppColor.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.support,
                  style: TextStyle(color: AppColor.textPrimary, fontSize: 18),
                ),
              ),
              SizedBox(height: 8),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColor.lightDarkBackground,
                    ),
                    child: Row(
                      children: [
                        Text(
                          AppStrings.contactSupport,
                          style: TextStyle(color: AppColor.textSecondary),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.textSecondary,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColor.lightDarkBackground,
                    ),
                    child: Row(
                      children: [
                        Text(
                          AppStrings.contactSupport,
                          style: TextStyle(color: AppColor.textSecondary),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.textSecondary,
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
            label: 'Market',
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
