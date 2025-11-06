import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/common/extensions/extensions_widget.dart';
import 'package:hamro_bike/common/widgets/snackbar.dart';

import '../controller/create_post_controller.dart';

class PartThree extends StatelessWidget {
  const PartThree({super.key, required this.controller});

  final CreatePostController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(50.h),
            InkWell(
              onTap: () => controller.pickImages(),
              child: Obx(
                () => controller.tempImagePaths.isNotEmpty
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
              ),
            ),

            Gap(150.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  child: Text("Previous", style: context.textTheme.bodyMedium),
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
                    if (controller.tempImagePaths.isEmpty) {
                      snackbar('Please upload at least one image.', Colors.red);
                      return;
                    }

                    await controller.postData();
                  },
                  child: Text("Submit", style: context.textTheme.bodyMedium),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
