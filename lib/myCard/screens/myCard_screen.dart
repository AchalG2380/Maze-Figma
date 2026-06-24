import 'package:flutter/material.dart';
import 'package:maze/core/app_color.dart';
import 'package:maze/core/app_strings.dart';
import 'package:maze/appWidgets/app_widgets.dart';
import 'package:get/get.dart';
import '../widgets/mycard_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/mycard_controller.dart';
import '../../news/screens/news_screen.dart';

class MyCardScreen extends StatelessWidget {
  const MyCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyCardController());
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              CustomScreenHeader(
                title: AppStrings.myCard,
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
                    onPressed: () => Get.to(() => const NewsScreen()),
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
              Stack(
                clipBehavior:
                    Clip.none, // allows cards to overflow outside Stack bounds
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 0,
                    child: Transform.rotate(
                      angle: 0.15,
                      alignment: Alignment.topLeft, // rotate from top center
                      child: Container(
                        width: 300, // fixed width, not double.infinity
                        height: 200,
                        decoration: BoxDecoration(
                          color: AppColor.primary.withValues(alpha: .3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Transform.translate(
                      offset: const Offset(0, 9), // push down less
                      child: Transform.rotate(
                        angle: 0.05,
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 320, // fixed width, not double.infinity
                          height: 200,
                          decoration: BoxDecoration(
                            color: AppColor.primary.withValues(alpha: .5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      width: 340, // fixed width, not double.infinity
                      height: 200,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.cardHolder,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.textPrimary,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            AppStrings.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/Credit card chip.svg',
                              ),
                              Spacer(),
                              Text(
                                AppStrings.cardNumber,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.textPrimary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset(
                                  "assets/images/cardlogo.png",
                                  height: 25,
                                  width: 40,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                AppStrings.mastercard,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.textPrimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),

              NamedCardWidgets(name: AppStrings.operations),

              SingleChildScrollView(
                controller: controller.scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: List.generate(
                    5,
                    (index) => Row(
                      children: [
                        BalanceRow(title: AppStrings.balanceW),
                        if (index < 4) SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    final isActive = controller.activeIndex.value == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 16 : 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColor.primary
                            : AppColor.textSecondary,
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 10),

              NamedCardWidgets(name: AppStrings.transactions),

              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.today,
                      style: const TextStyle(
                        color: AppColor.textPrimary,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      width: 140,
                      height: 30,
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: AppColor.textSecondary),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: AppColor.textSecondary),
                          SizedBox(width: 4),
                          Expanded(
                            child: TextField(
                              style: TextStyle(color: AppColor.textPrimary),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                hintText: AppStrings.search,
                                hintStyle: TextStyle(
                                  color: AppColor.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              Column(
                children: List.generate(
                  5,
                  (index) => Column(
                    children: [
                      TodayRow(
                        name: AppStrings.shopping,
                        date: AppStrings.shoppingTime,
                        amount: AppStrings.shoppingAmount,
                      ),
                      if (index < 4) SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      // Reusable Floating Scanner Button
      floatingActionButton: CustomScanFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
