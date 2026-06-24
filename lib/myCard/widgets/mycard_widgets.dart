import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BalanceRow extends StatelessWidget {
  final String title;

  const BalanceRow({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColor.lightDarkBackground,
        border: Border.all(color: AppColor.primary, width: 1),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Icon(Icons.circle, color: AppColor.lightBackground, size: 40),
              Positioned(
                top: 12,
                left: 10,
                child: SvgPicture.asset('assets/icons/AccountBalance.svg'),
              ),
            ],
          ),
          SizedBox(width: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.textPrimary,
              fontWeight: FontWeight.w500,
            ),
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
    return CustomPaint(
      foregroundPainter: RoundedNonUniformBorderPainter(
        radius: 8,
        topColor: AppColor.primary,
        leftColor: AppColor.primary,
        rightColor: AppColor.primary.withValues(alpha: 0.2),
        bottomColor: AppColor.primary.withValues(alpha: 0.2),
        strokeWidth: 1.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: const BoxDecoration(color: AppColor.lightDarkBackground),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  "assets/images/Shopping.png",
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      color: AppColor.textPrimary,
                      fontSize: 10,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(amount, style: const TextStyle(color: AppColor.textPrimary)),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedNonUniformBorderPainter extends CustomPainter {
  final double radius;
  final Color topColor;
  final Color leftColor;
  final Color rightColor;
  final Color bottomColor;
  final double strokeWidth;

  RoundedNonUniformBorderPainter({
    required this.radius,
    required this.topColor,
    required this.leftColor,
    required this.rightColor,
    required this.bottomColor,
    this.strokeWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double r = radius;
    final double offset = strokeWidth / 2;

    final rect = Rect.fromLTWH(
      offset,
      offset,
      w - strokeWidth,
      h - strokeWidth,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(r));

    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [topColor, topColor, rightColor],
        stops: const [
          0.0,
          0.5, // 50% of diagonal path remains solid
          1.0, // Fades to bottom/right color at the corner
        ],
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant RoundedNonUniformBorderPainter oldDelegate) {
    return oldDelegate.radius != radius ||
        oldDelegate.topColor != topColor ||
        oldDelegate.leftColor != leftColor ||
        oldDelegate.rightColor != rightColor ||
        oldDelegate.bottomColor != bottomColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
