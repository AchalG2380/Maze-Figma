import 'package:flutter/material.dart';
import 'package:maze/Scan/screens/scan_screen.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:maze/home/screens/home_screen.dart';
import 'package:maze/market/screens/market_screen.dart';
import 'package:maze/profile/screens/profile_screen.dart';
import 'package:maze/tradingDetails/screens/tradingDetails_screen.dart';
import 'package:maze/appWidgets/appWidgets.dart';
import '../widgets/news_widgets.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back_ios, color: AppColor.textPrimary),
                    Spacer(),
                    Center(
                      child: Text(
                        AppStrings.news,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.textPrimary,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.bookmarks_outlined, color: AppColor.textPrimary),
                    Icon(Icons.search, color: AppColor.textPrimary),
                  ],
                ),
              ),

              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/news.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.85),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          AppStrings.CRYPTOCURRENCY,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Coinbase says hackers stole cryptocurrency from at least 6,000 customers",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Column(
                children: List.generate(
                  5,
                  (index) => const NewsItemWidget(
                    imageUrl:
                        "assets/images/d976d932ff879e4f27d10fa69fcd2d5b3a11521e.jpg",
                    title: AppStrings.newsTitle,
                    website: AppStrings.newsWebsite,
                    time: AppStrings.newsTime,
                  ),
                ),
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
