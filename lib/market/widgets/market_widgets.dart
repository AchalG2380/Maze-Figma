import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';

class TimelineWidget extends StatelessWidget {
  const TimelineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.lightDarkBackground,
      ),
      child: Column(
        children: [
          Image.asset('assets/images/Analytics.png'),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColor.textRed),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 5,
                    ),
                  ),
                  child: Text(
                    "- Sell",
                    style: TextStyle(color: AppColor.textRed, fontSize: 14),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    padding: WidgetStatePropertyAll(
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
                    ),
                  ),
                  child: Text(
                    "Buy +",
                    style: TextStyle(
                      color: AppColor.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MarketDepthWidget extends StatelessWidget {
  const MarketDepthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.lightDarkBackground,
      ),
      child: Image.asset('assets/images/oderbookMarketGraph.png'),
    );
  }
}

class LatestTradesRow extends StatelessWidget {
  final String amount;
  final String price;
  final String time;

  const LatestTradesRow({
    super.key,
    required this.amount,
    required this.price,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(amount, style: TextStyle(color: AppColor.textSecondary)),
        Text(price, style: TextStyle(color: AppColor.textGreen)),
        Text(time, style: TextStyle(color: AppColor.textSecondary)),
      ],
    );
  }
}
