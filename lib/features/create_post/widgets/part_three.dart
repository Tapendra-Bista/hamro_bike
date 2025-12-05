import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
                        items: controller.tempImagePaths.map((path) {
                          // Check if path is a URL or local file
                          final isUrl =
                              path.startsWith('http://') ||
                              path.startsWith('https://');

                          Widget imageWidget = isUrl
                              ? CachedNetworkImage(
                                  imageUrl: path,
                                  fit: BoxFit.cover,
                                  key: ValueKey(path),
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.w,
                                      color: ConstantColors.primaryButtonColor,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                )
                              : Image.file(
                                  File(path),
                                  fit: BoxFit.cover,
                                  key: ValueKey(path),
                                );

                          return imageWidget
                              .rounded(18.r)
                              .paddingSymmetric(horizontal: 5.w);
                        }).toList(),
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
                    if (controller.tempImagePaths.isEmpty &&
                        controller.imageUrls.isEmpty) {
                      snackbar(ConstantStrings.imageWarning, Colors.red);
                      return;
                    }
                    final BuildContext newContext = context;
                    final success = controller.isEditMode
                        ? await controller.updatePost()
                        : await controller.postData();
                    if (success) {
                      snackbar(
                        controller.isEditMode
                            ? 'Post updated successfully!'
                            : ConstantStrings.postCreateSuccess,
                        ConstantColors.primaryButtonColor,
                      );
                      // Navigate first
                      if (newContext.mounted) {
                        if (controller.isEditMode) {
                          Get.back(result: true);
                        } else {
                          Get.offAllNamed(RoutesName.dashboard);
                        }
                      }
                    }
                  },
                  child: Obx(
                    () => Text(
                      controller.isEditMode ? 'Update' : ConstantStrings.submit,
                      style: context.textTheme.bodyMedium,
                    ),
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
