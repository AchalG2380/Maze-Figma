import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';

class SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title;

  const SettingsRow({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColor.lightDarkBackground,
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColor.textSecondary),
          SizedBox(width: 20),
          Text(title, style: TextStyle(color: AppColor.textSecondary)),
          Spacer(),
        ],
      ),
    );
  }
}

class SupportRow extends StatelessWidget {
  final String title;

  const SupportRow({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColor.lightDarkBackground,
      ),
      child: Row(
        children: [
          Text(title, style: TextStyle(color: AppColor.textSecondary)),
          Spacer(),
          Icon(Icons.arrow_forward_ios, color: AppColor.textSecondary),
        ],
      ),
    );
  }
}

class OptionRow extends StatelessWidget {
  final String title;
  final Widget? trailing; // optional — Switch, Icon, or nothing

  const OptionRow({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColor.lightDarkBackground,
      ),
      child: Row(
        children: [
          Text(title, style: TextStyle(color: AppColor.textSecondary)),
          Spacer(),
          if (trailing != null) trailing!, // ✅ only renders if passed
        ],
      ),
    );
  }
}
