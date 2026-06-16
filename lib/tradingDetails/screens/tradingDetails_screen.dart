import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:maze/home/screens/home_screen.dart';
import 'package:maze/market/screens/market_screen.dart';
import 'package:maze/profile/screens/profile_screen.dart';
import '../../scan/screens/scan_Screen.dart';
import '../../myCard/screens/myCard_screen.dart';
import 'package:get/get.dart';
import 'package:maze/appWidgets/appWidgets.dart';

class TradingdetailsScreen extends StatelessWidget {
  const TradingdetailsScreen({super.key});

  Widget _buildPriceRow({
    required String price,
    required String amount,
    required Color priceColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(price, style: TextStyle(color: priceColor, fontSize: 12)),
          Text(
            amount,
            style: const TextStyle(color: AppColor.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomScreenHeader(
                title: AppStrings.tradingDetails,
                leading: const Icon(Icons.menu, color: AppColor.textPrimary),
                actions: [
                  IconButton(
                    onPressed: () => Get.to(() => const MyCardScreen()),
                    icon: const Icon(Icons.wallet, color: AppColor.textPrimary),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColor.lightBackground),
                        color: AppColor.lightDarkBackground,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Spacer(),
                              Text(
                                AppStrings.high,
                                style: TextStyle(color: AppColor.textGreen),
                              ),
                              Spacer(),
                              Text(
                                AppStrings.low,
                                style: TextStyle(color: AppColor.textRed),
                              ),
                              Spacer(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Spacer(),
                              Text(
                                AppStrings.highPrice,
                                style: TextStyle(color: AppColor.textPrimary),
                              ),
                              Spacer(),
                              Text(
                                AppStrings.lowPrice,
                                style: TextStyle(color: AppColor.textPrimary),
                              ),
                              Spacer(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Spacer(),
                              Text(
                                AppStrings.volBTC,
                                style: TextStyle(color: AppColor.textSecondary),
                              ),
                              Spacer(),
                              Text(
                                AppStrings.volETH,
                                style: TextStyle(color: AppColor.textSecondary),
                              ),
                              Spacer(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Spacer(),
                              Text(
                                AppStrings.highPrice,
                                style: TextStyle(color: AppColor.textPrimary),
                              ),
                              Spacer(),
                              Text(
                                AppStrings.lowPrice,
                                style: TextStyle(color: AppColor.textPrimary),
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            AppStrings.price,
                            style: TextStyle(
                              color: AppColor.textPrimary,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            AppStrings.priceChange,
                            style: TextStyle(color: AppColor.textGreen),
                          ),
                          SizedBox(height: 20),
                          DropdownButton(
                            items: [
                              DropdownMenuItem(
                                child: Text(
                                  AppStrings.currency,
                                  style: TextStyle(
                                    color: AppColor.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(12),
                        ),
                        color: AppColor.lightDarkBackground,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 450,
                            width: double.infinity,
                            child: ClipRRect(
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: -60,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: Image.asset(
                                      'assets/images/Analytics.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primary,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    "H1",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primary,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.reply,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primary,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.language,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(AppStrings.open),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Text(AppStrings.filled),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Text(AppStrings.cancelled),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 4,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                AppStrings.orderBook,
                                style: TextStyle(color: AppColor.textPrimary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ...List.generate(
                            6,
                            (_) => _buildPriceRow(
                              price: AppStrings.orderBookPrice,
                              amount: AppStrings.orderBookPrice,
                              priceColor: AppColor.textGreen,
                            ),
                          ),
                          ...List.generate(
                            6,
                            (_) => _buildPriceRow(
                              price: AppStrings.orderBookPrice,
                              amount: AppStrings.orderBookPrice,
                              priceColor: AppColor.textRed,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                AppStrings.trades,
                                style: TextStyle(color: AppColor.textPrimary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ...List.generate(
                            6,
                            (_) => _buildPriceRow(
                              price: AppStrings.orderBookPrice,
                              amount: AppStrings.orderBookPrice,
                              priceColor: AppColor.textGreen,
                            ),
                          ),
                          ...List.generate(
                            6,
                            (_) => _buildPriceRow(
                              price: AppStrings.orderBookPrice,
                              amount: AppStrings.orderBookPrice,
                              priceColor: AppColor.textRed,
                            ),
                          ),
                          const SizedBox(height: 22),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Reusable Notch Bottom App Bar
      bottomNavigationBar: CustomBottomAppBar(
        currentIndex:
            0, // 0 for Home, 1 for Wallet, 2 for Market, 3 for Profile
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
