import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:maze/home/screens/home_screen.dart';
import 'package:maze/market/screens/market_screen.dart';
import 'package:maze/tradingDetails/screens/tradingDetails_screen.dart';
import '../../scan/screens/scan_screen.dart';
import 'package:maze/appWidgets/appWidgets.dart';
import '../widgets/profile_widgets.dart';

const List<Map<String, dynamic>> _settingsItems = [
  {'icon': Icons.edit_document, 'title': AppStrings.edit},
  {'icon': Icons.lock_open, 'title': AppStrings.editPass},
  {'icon': Icons.money, 'title': AppStrings.currencyW},
  {'icon': Icons.shield_outlined, 'title': AppStrings.twoFactorAuthentication},
];

const List<Map<String, dynamic>> supportRowItems = [
  {'title': AppStrings.contactSupport},
  {'title': AppStrings.notificationSett},
];

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
              CustomScreenHeader(
                title: AppStrings.profile,
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColor.textPrimary,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: AppColor.textPrimary,
                    ),
                  ),
                ],
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
                          BoxShadow(color: AppColor.high, spreadRadius: 2),
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
                children: _settingsItems.map((item) {
                  return Column(
                    children: [
                      SettingsRow(
                        icon: item['icon'] as IconData,
                        title: item['title'] as String,
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                }).toList(),
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
                  OptionRow(
                    title: AppStrings.faceID,
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  SizedBox(height: 8),
                  OptionRow(
                    title: AppStrings.notificationSett,
                    // no trailing = nothing rendered after Spacer
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
                children: supportRowItems.map((item) {
                  return Column(
                    children: [
                      SupportRow(title: item['title'] as String),
                      SizedBox(height: 8),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      // Reusable Notch Bottom App Bar
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
