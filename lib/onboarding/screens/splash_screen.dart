import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import '../../home/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    // 1. Setup animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scale = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut, // ← the pop effect
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward(); // ← start animation

    // 2. Navigate after delay
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // ← always dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightBackground3,
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _CurvePainter(color: AppColor.background),
            ),
          ),

          // Logo with pop animation
          Center(
            child: ScaleTransition(
              scale: _scale,
              child: FadeTransition(
                opacity: _fade,
                child: Image.asset('assets/images/Logo.png'),
              ),
            ),
          ),
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

    path.moveTo(0, size.height * 0.98);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.45,
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
