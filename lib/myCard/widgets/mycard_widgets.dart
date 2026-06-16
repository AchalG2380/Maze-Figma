import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';

class BalanceRow extends StatelessWidget {
  final String title;

  const BalanceRow({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: AppColor.surface,
        border: Border.all(color: AppColor.primary, width: 1),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Icon(Icons.circle, color: AppColor.lightBackground, size: 40),
              Positioned(
                top: 8,
                left: 8,
                child: Icon(Icons.money, color: AppColor.textPrimary),
              ),
            ],
          ),
          SizedBox(width: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.textSecondary),
          ),
        ],
      ),
    );
  }
}

class TodayRow extends StatelessWidget {
  final String name;
  final String date;
  final String amount;

  const TodayRow({
    super.key,
    required this.name,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.lightDarkBackground,
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: AppColor.textSecondary, size: 50),
          Column(
            children: [
              Text(name, style: const TextStyle(color: AppColor.textSecondary)),
              Text(date, style: const TextStyle(color: AppColor.textSecondary)),
            ],
          ),
          const Spacer(),
          Text(amount, style: const TextStyle(color: AppColor.textSecondary)),
        ],
      ),
    );
  }
}
