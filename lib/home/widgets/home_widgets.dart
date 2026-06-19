import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import '../../appWidgets/app_charts.dart';

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
  final Color color;
  final List<double> dataPoints;

  const MarketStatistics({
    super.key,
    required this.price,
    required this.name,
    required this.today,
    required this.logoUrl,
    required this.color,
    required this.dataPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(top: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.lightDarkBackground,
          border: Border.all(color: AppColor.secondary, width: 1),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
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
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  name,
                  style: TextStyle(color: AppColor.textSecondary),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(today, style: TextStyle(color: color)),
              ),
            ),
            Center(
              child: SizedBox(
                height: 65,
                child: CustomPaint(
                  size: const Size(double.infinity, 120),
                  painter: AreaChartPainter(
                    dataPoints: dataPoints,
                    lineColor: color == AppColor.textGreen
                        ? AppColor.oderbookGreen
                        : AppColor.oderbookRed,
                    gradientTop: color == AppColor.textGreen
                        ? AppColor.oderbookGreen.withValues(alpha: 0.8)
                        : AppColor.oderbookRed.withValues(alpha: 0.8),
                    gradientBottom: color == AppColor.textGreen
                        ? AppColor.oderbookGreen.withValues(alpha: 0.0)
                        : AppColor.oderbookRed.withValues(alpha: 0.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
