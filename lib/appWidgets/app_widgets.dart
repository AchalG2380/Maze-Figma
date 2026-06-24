import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maze/myCard/screens/myCard_screen.dart';
import '../home/screens/home_screen.dart';
import '../market/screens/market_screen.dart';
import '../profile/screens/profile_screen.dart';
import '../scan/screens/scan_screen.dart';
import 'package:get/get.dart';
import '../core/app_strings.dart';

/// A reusable custom header widget that matches the design of the screens in the Maze app.
class CustomScreenHeader extends StatelessWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomScreenHeader({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Leading widget or an empty spacer to preserve layout alignment
          leading ?? const SizedBox(width: 48),

          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColor.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Trailing actions row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: actions ?? [const SizedBox(width: 48)],
          ),
        ],
      ),
    );
  }
}

/// A reusable bottom navigation bar matching the notch design.
/// Communicates user selection back to the parent using the [onTap] callback.
class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColor.lightBackground3,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabIcon(
              icon: SvgPicture.asset('assets/icons/home.svg'),
              onPressed: () => Get.off(() => HomeScreen()),
            ),
            _buildTabIcon(
              icon: SvgPicture.asset('assets/icons/wallet.svg'),
              onPressed: () => Get.off(() => MyCardScreen()),
            ),
            const SizedBox(width: 32), // Notch gap for the central FAB
            _buildTabIcon(
              icon: SvgPicture.asset('assets/icons/stock_market.svg'),
              onPressed: () => Get.off(() => MarketScreen()),
            ),
            _buildTabIcon(
              icon: SvgPicture.asset('assets/icons/profile.svg'),
              onPressed: () => Get.off(() => ProfileScreen()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabIcon({
    required Widget icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(icon: icon, onPressed: onPressed);
  }
}

/// A reusable Floating Action Button matching the custom scanner notch button design.
class CustomScanFAB extends StatelessWidget {
  const CustomScanFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.primary.withValues(alpha: 0.5),
        border: Border.all(color: Colors.blue.shade300, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondary.withValues(alpha: 0.5),
            blurRadius: 14,
            spreadRadius: 3,
          ),
        ],
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/scan.svg',
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        onPressed: () => Get.off(() => ScanScreens()),
      ),
    );
  }
}

class NamedCardWidgets extends StatelessWidget {
  final String name;
  const NamedCardWidgets({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14, bottom: 10, left: 3, right: 3),
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.lightBackground3,
      ),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColor.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class TradeHeader extends StatelessWidget {
  const TradeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColor.secondary),
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
                          style: TextStyle(color: AppColor.textGreen),
                        ),
                        SizedBox(height: 5),
                        Text(
                          AppStrings.highPrice,
                          style: TextStyle(
                            color: AppColor.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          AppStrings.low,
                          style: TextStyle(color: AppColor.textRed),
                        ),
                        SizedBox(height: 5),
                        Text(
                          AppStrings.lowPrice,
                          style: TextStyle(
                            color: AppColor.textPrimary,
                            fontWeight: FontWeight.w600,
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
                          style: TextStyle(color: AppColor.textSecondary),
                        ),
                        SizedBox(height: 5),
                        Text(
                          AppStrings.highPrice,
                          style: TextStyle(
                            color: AppColor.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          AppStrings.volETH,
                          style: TextStyle(color: AppColor.textSecondary),
                        ),
                        SizedBox(height: 5),
                        Text(
                          AppStrings.lowPrice,
                          style: TextStyle(
                            color: AppColor.textPrimary,
                            fontWeight: FontWeight.w600,
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppStrings.tradBalance,
                  style: TextStyle(
                    color: AppColor.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppStrings.priceChange,
                  style: TextStyle(
                    color: AppColor.high,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: AppColor.lightBackground2.withValues(alpha: .6),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton(
                    value: AppStrings.currency,
                    dropdownColor: AppColor.lightDarkBackground,
                    iconEnabledColor: AppColor.textPrimary,
                    items: [
                      DropdownMenuItem<String>(
                        value: AppStrings.currency,
                        child: Text(
                          AppStrings.currency,
                          style: TextStyle(color: AppColor.textPrimary),
                        ),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
