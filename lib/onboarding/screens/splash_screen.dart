import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import '/home/screens/home_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background, // navy
      body: Stack(
        children: [
          // The curved second color
          Positioned.fill(
            child: CustomPaint(painter: _CurvePainter(color: AppColor.surface)),
          ),
          // Logo on top
          Center(child: Image.asset('assets/images/Logo.png')),
        ],
      ),
    );
  }
}

class _CurvePainter extends CustomPainter {
  final Color color;
  _CurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    // Start from bottom-left area, curve up to top-right
    path.moveTo(0, size.height * 0.98);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.50,
      size.width,
      size.height * 0.40,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
