import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:maze/appWidgets/app_widgets.dart';
import '../widgets/profile_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

final List<Map<String, dynamic>> _settingsItems = [
  {
    'icon': SvgPicture.asset('assets/icons/AllEdit.svg', width: 15),
    'title': AppStrings.edit,
  },
  {
    'icon': SvgPicture.asset('assets/icons/Password.svg', width: 15),
    'title': AppStrings.editPass,
  },
  {
    'icon': SvgPicture.asset('assets/icons/AccountBalance.svg', width: 15),
    'title': AppStrings.currencyW,
  },
  {
    'icon': SvgPicture.asset('assets/icons/Security.svg', width: 15),
    'title': AppStrings.twoFactorAuthentication,
  },
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
                  icon: SvgPicture.asset('assets/icons/Outline.svg'),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/Settings.svg'),
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
                        child: SvgPicture.asset("assets/icons/Camera.svg"),
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
                        icon: item['icon'] as Widget,
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
      bottomNavigationBar: CustomBottomAppBar(),
      // Reusable Floating Scanner Button
      floatingActionButton: CustomScanFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
