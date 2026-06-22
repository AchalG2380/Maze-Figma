import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                fontSize: 20,
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
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomAppBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColor.secondary,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabIcon(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 0
                      ? AppColor.textPrimary
                      : AppColor.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              index: 0,
            ),
            _buildTabIcon(
              icon: SvgPicture.asset(
                'assets/icons/wallet.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 1
                      ? AppColor.textPrimary
                      : AppColor.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              index: 1,
            ),
            const SizedBox(width: 32), // Notch gap for the central FAB
            _buildTabIcon(
              icon: SvgPicture.asset(
                'assets/icons/stock_market.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 2
                      ? AppColor.textPrimary
                      : AppColor.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              index: 2,
            ),
            _buildTabIcon(
              icon: SvgPicture.asset(
                'assets/icons/profile.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 3
                      ? AppColor.textPrimary
                      : AppColor.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabIcon({required Widget icon, required int index}) {
    return IconButton(icon: icon, onPressed: () => onTap(index));
  }
}

/// A reusable Floating Action Button matching the custom scanner notch button design.
class CustomScanFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomScanFAB({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.surface,
        border: Border.all(color: Colors.blue.shade300, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColor.primary.withValues(alpha: 0.5),
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
        onPressed: onPressed,
      ),
    );
  }
}

class namedCardWidgets extends StatelessWidget {
  final String name;
  const namedCardWidgets({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14, bottom: 10, left: 3, right: 3),
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.surface,
      ),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColor.textSecondary),
      ),
    );
  }
}
