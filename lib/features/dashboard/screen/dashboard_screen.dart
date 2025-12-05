import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:hamro_bike/features/dashboard/controller/dashboard_controller.dart';

// Dashboard screen
class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is registered when this screen is constructed directly (not via route binding)
    if (!Get.isRegistered<DashboardController>()) {
      Get.lazyPut<DashboardController>(() => .new());
    }
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex,
          children: dashboardPages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => GNav(
          selectedIndex: controller.selectedIndex,
          onTabChange: (index) {
            controller.selectedIndex = index;
          },
          gap: 8.w,
          padding: .symmetric(horizontal: 10.w, vertical: 8.h),
          backgroundColor: ConstantColors.backgroundColor,
          color: ConstantColors.secondaryTextColor,
          activeColor: Colors.white,
          // tabBackgroundColor: Colors.grey.shade800,
          tabBackgroundColor: ConstantColors.primaryButtonColor.withValues(
            alpha: 0.8,
          ),
          hoverColor: Colors.grey.shade700,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 400),

          tabs: [
            GButton(
              padding: .all(15.r),
              icon: Icons.directions_bike_outlined,
              text: ConstantStrings.bikesTab,
              textStyle: context.textTheme.bodyMedium!.copyWith(
                fontWeight: .bold,
                color: Colors.white,
              ),
            ),
            GButton(
              padding: .all(15.r),
              icon: CupertinoIcons.search,
              text: ConstantStrings.searchTab,
              textStyle: context.textTheme.bodyMedium!.copyWith(
                fontWeight: .bold,
                color: Colors.white,
              ),
            ),

            GButton(
              padding: .all(15.r),
              icon: CupertinoIcons.chat_bubble,
              text: ConstantStrings.chatTab,
              textStyle: context.textTheme.bodyMedium!.copyWith(
                fontWeight: .bold,
                color: Colors.white,
              ),
            ),
            GButton(
              padding: .all(15.r),
              icon: CupertinoIcons.person,
              text: ConstantStrings.profileTab,
              textStyle: context.textTheme.bodyMedium!.copyWith(
                fontWeight: .bold,
                color: Colors.white,
              ),
            ),
          ],
        ).paddingAll(12.w),
      ),
    );
  }
}
