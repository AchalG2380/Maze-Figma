import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:maze/home/screens/home_screen.dart';
import 'package:maze/appWidgets/app_widgets.dart';
import '../widgets/news_widgets.dart';
import 'package:get/get.dart';

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
              CustomScreenHeader(
                title: AppStrings.news,
                leading: IconButton(
                  onPressed: () => Get.to(() => const HomeScreen()),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColor.textPrimary,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.bookmark_border_outlined,
                      color: AppColor.textPrimary,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: AppColor.textPrimary),
                    onPressed: () {},
                  ),
                ],
              ),

              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage('assets/images/news.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, AppColor.secondary],
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category badge
                      Text(
                        AppStrings.CRYPTOCURRENCY,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Headline
                      Text(
                        'Coinbase says hackers stole cryptocurrency from at least 6,000 customers', // ← parameter
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          AppStrings.newsWebsite,
                          style: const TextStyle(
                            color: AppColor.textPrimary,
                            fontSize: 12,
                          ),
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
      bottomNavigationBar: CustomBottomAppBar(),
      // Reusable Floating Scanner Button
      floatingActionButton: CustomScanFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
