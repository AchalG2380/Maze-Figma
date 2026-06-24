import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import '../../appWidgets/app_charts.dart';

class RecentTransactions extends StatelessWidget {
  final Widget icon;
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
        color: AppColor.lightBackground2,
        border: Border.all(color: AppColor.secondary, width: 1),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              padding: EdgeInsets.all(5),
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: AppColor.lightDarkBackground,
                borderRadius: BorderRadius.circular(2),
              ),
              child: icon,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                titleDate,
                style: TextStyle(color: AppColor.textPrimary, fontSize: 13),
              ),
            ],
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              amount,
              style: TextStyle(color: color, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class MarketStatistics extends StatelessWidget {
  final String price;
  final String coin;
  final String name;
  final String today;
  final Widget arrow;
  final String logoUrl;
  final Color color;
  final List<double> dataPoints;

  const MarketStatistics({
    super.key,
    required this.price,
    required this.coin,
    required this.name,
    required this.today,
    required this.logoUrl,
    required this.color,
    required this.arrow,
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
          border: Border.all(color: AppColor.surface, width: 1),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        logoUrl,
                        width: 30,
                        height: 30,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          color: AppColor.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                price,
                                style: TextStyle(
                                  color: AppColor.textPrimary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              coin,
                              style: TextStyle(
                                color: AppColor.textSecondary,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      today,
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      child: arrow,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),

            Center(
              child: SizedBox(
                height: 65,
                child: CustomPaint(
                  size: const Size(double.infinity, 120),
                  painter: AreaChartPainter(
                    dataPoints: dataPoints,
                    lineColor: color == AppColor.high
                        ? AppColor.oderbookGreen
                        : AppColor.oderbookRed,
                    gradientTop: color == AppColor.high
                        ? AppColor.oderbookGreen.withValues(alpha: 0.8)
                        : AppColor.oderbookRed.withValues(alpha: 0.8),
                    gradientBottom: color == AppColor.high
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
