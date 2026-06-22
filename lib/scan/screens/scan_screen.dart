import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:maze/home/screens/home_screen.dart';
import 'package:maze/market/screens/market_screen.dart';
import 'package:maze/profile/screens/profile_screen.dart';
import 'package:maze/tradingDetails/screens/tradingDetails_screen.dart';
import '../../myCard/screens/myCard_screen.dart';
import 'package:get/get.dart';
import 'package:maze/appWidgets/app_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanScreens extends StatefulWidget {
  const ScanScreens({super.key});

  @override
  State<ScanScreens> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreens>
    with SingleTickerProviderStateMixin {
  final MobileScannerController _controller = MobileScannerController();
  late AnimationController _animController;
  late Animation<double> _scanAnim;
  bool _scanned = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_scanned) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue != null) {
      setState(() => _scanned = true);
      _controller.stop();
      _animController.stop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Scanned: ${barcode!.rawValue}'),
          backgroundColor: AppColor.primary,
        ),
      );

      // navigate or do something with barcode.rawValue here
    }
  }

  @override
  Widget build(BuildContext context) {
    final double scanSize = MediaQuery.of(context).size.width * 0.70;
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              CustomScreenHeader(
                title: AppStrings.scan,
                leading: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/menu.svg',
                    colorFilter: ColorFilter.mode(
                      AppColor.textPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () => Get.to(() => const MyCardScreen()),
                    icon: SvgPicture.asset(
                      'assets/icons/notification.svg',
                      colorFilter: ColorFilter.mode(
                        AppColor.textPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50),

              Text(
                AppStrings.scanInfo,
                style: TextStyle(color: AppColor.textPrimary, fontSize: 14),
              ),

              SizedBox(height: 100),

              // ── Scan frame ───────────────────────────
              Center(
                child: SizedBox(
                  width: scanSize,
                  height: scanSize,
                  child: Stack(
                    children: [
                      // 1. Live camera feed clipped to frame
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: MobileScanner(
                          controller: _controller,
                          onDetect: _onDetect,
                        ),
                      ),

                      // 2. Corner brackets on top of camera
                      CustomPaint(
                        size: Size(scanSize, scanSize),
                        painter: _CornerPainter(),
                      ),

                      // 3. Animated scan line
                      AnimatedBuilder(
                        animation: _scanAnim,
                        builder: (context, _) {
                          return Positioned(
                            // moves from top to bottom of frame
                            top: _scanAnim.value * (scanSize - 3),
                            left: 12,
                            right: 12,
                            child: Container(
                              height: 2.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColor.transparent,
                                    AppColor.lightBackground,
                                    AppColor.QR,
                                    AppColor.lightBackground,
                                    AppColor.transparent,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.QR.withValues(alpha: 0.7),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),

              Text(
                AppStrings.scanStart,
                style: TextStyle(color: AppColor.textPrimary, fontSize: 12),
              ),

              SizedBox(height: 100),

              ElevatedButton(
                onPressed: () => Get.to(() => const HomeScreen()),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  backgroundColor: AppColor.button2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: AppColor.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
      // Reusable Notch Bottom App Bar
      bottomNavigationBar: CustomBottomAppBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MarketScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const TradingdetailsScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
              break;
          }
        },
      ),
      // Reusable Floating Scanner Button
      floatingActionButton: CustomScanFAB(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const ScanScreens()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// ── Corner bracket painter ───────────────────────────────
class _CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade400
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const arm = 28.0; // length of each bracket arm
    const r = 10.0; // corner radius of bracket

    // ── Top Left ──
    canvas.drawPath(
      Path()
        ..moveTo(0, arm)
        ..lineTo(0, r)
        ..arcToPoint(Offset(r, 0), radius: const Radius.circular(r))
        ..lineTo(arm, 0),
      paint,
    );

    // ── Top Right ──
    canvas.drawPath(
      Path()
        ..moveTo(size.width - arm, 0)
        ..lineTo(size.width - r, 0)
        ..arcToPoint(Offset(size.width, r), radius: const Radius.circular(r))
        ..lineTo(size.width, arm),
      paint,
    );

    // ── Bottom Left ──
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height - arm)
        ..lineTo(0, size.height - r)
        ..arcToPoint(
          Offset(r, size.height),
          radius: const Radius.circular(r),
          clockwise: false,
        )
        ..lineTo(arm, size.height),
      paint,
    );

    // ── Bottom Right ──
    canvas.drawPath(
      Path()
        ..moveTo(size.width - arm, size.height)
        ..lineTo(size.width - r, size.height)
        ..arcToPoint(
          Offset(size.width, size.height - r),
          radius: const Radius.circular(r),
          clockwise: false,
        )
        ..lineTo(size.width, size.height - arm),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
