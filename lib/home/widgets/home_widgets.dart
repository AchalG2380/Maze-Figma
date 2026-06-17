import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';

class RecentTransactions extends StatelessWidget {
  final IconData icon;
  final String title;
  final String titleDate;
  final String amount;
  final Color color;
  const RecentTransactions({
    super.key,
    required this.icon,
    required this.title,
    required this.titleDate,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3.0),
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.lightDarkBackground,
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: AppColor.textPrimary)),
              Text(titleDate, style: TextStyle(color: AppColor.textSecondary)),
            ],
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(amount, style: TextStyle(color: color)),
          ),
        ],
      ),
    );
  }
}

class MarketStatistics extends StatelessWidget {
  final String price;
  final String name;
  final String today;
  final String logoUrl;
  final String imageUrl;
  final Color color;

  const MarketStatistics({
    super.key,
    required this.price,
    required this.name,
    required this.today,
    required this.logoUrl,
    required this.imageUrl,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(top: 14, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.lightDarkBackground,
          border: Border.all(color: AppColor.secondary, width: 1),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  logoUrl,
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    price,
                    style: TextStyle(color: AppColor.textPrimary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                name,
                style: TextStyle(color: AppColor.textSecondary),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(today, style: TextStyle(color: color)),
            ),
            Center(child: Image.asset(imageUrl)),
          ],
        ),
      ),
    );
  }
}
