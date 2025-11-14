import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/common/extensions/extensions_widget.dart';
import 'package:hamro_bike/common/widgets/snackbar.dart';
import 'package:hamro_bike/routes/routes_name.dart';

import '../controller/create_post_controller.dart';

class PartThree extends StatelessWidget {
  const PartThree({super.key, required this.controller});

  final CreatePostController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Center(
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .center,
          children: [
            Gap(50.h),
            Obx(() {
              return InkWell(
                onTap: () => controller.pickImages(),
                child: controller.tempImagePaths.isNotEmpty
                    ? FlutterCarousel(
                        items: controller.tempImagePaths
                            .map(
                              (path) => Image.file(
                                File(path),
                                fit: BoxFit.cover,
                                key: ValueKey(path),
                              ).rounded(18.r).paddingSymmetric(horizontal: 5.w),
                            )
                            .toList(),
                        options: FlutterCarouselOptions(
                          height: 250.0.h,
                          floatingIndicator: false,
                          showIndicator: true,
                          slideIndicator: CircularSlideIndicator(),
                        ),
                      )
                    : Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 110.sp,
                        color: ConstantColors.primaryTextColor,
                      ),
              );
            }),

            Gap(150.h),
            Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                ElevatedButton(
                  style: context.iconButtonTheme.style!.copyWith(
                    fixedSize: WidgetStatePropertyAll(Size(150.w, 35.h)),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.r),
                      ),
                    ),
                  ),
                  onPressed: () => controller.currentStep = 1,
                  child: Text(
                    ConstantStrings.previous,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                ElevatedButton(
                  style: context.iconButtonTheme.style!.copyWith(
                    fixedSize: WidgetStatePropertyAll(Size(150.w, 35.h)),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.r),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (controller.isLoading) return;
                    if (controller.tempImagePaths.isEmpty) {
                      snackbar(ConstantStrings.imageWarning, Colors.red);
                      return;
                    }
                    final success = await controller.postData();
                    if (success) {
                      // Delay slightly to ensure current build/frame settles (fixes visitChildElements errors
                      // that can happen when certain parent routes (e.g. SliverAppBar) are mid-build).
                      Future.delayed(const Duration(milliseconds: 300), () {
                        Get.offAllNamed(RoutesName.dashboard);
                        // Show snackbar shortly after navigation
                        Future.delayed(const Duration(milliseconds: 150), () {
                          snackbar(
                            ConstantStrings.postCreateSuccess,
                            ConstantColors.primaryButtonColor,
                          );
                        });
                      });
                    }
                  },
                  child: Text(
                    ConstantStrings.submit,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
