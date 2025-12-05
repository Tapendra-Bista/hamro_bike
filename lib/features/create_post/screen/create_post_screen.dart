import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../common/widgets/comman_back_button.dart';
import '../controller/create_post_controller.dart';
import '../widgets/part_one.dart';
import '../widgets/part_three.dart';
import '../widgets/part_two.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final CreatePostController controller = Get.find<CreatePostController>();

  @override
  void initState() {
    super.initState();

    // Check if we're in edit mode
    final args = Get.arguments;
    if (args != null && args is Map) {
      if (args['editMode'] == true && args['post'] != null) {
        controller.loadPostForEdit(args['post']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommanBackButton(),
        title: Obx(
          () => Text(
            controller.isEditMode
                ? 'Edit Post'
                : ConstantStrings.createPostForAds,
            style: context.textTheme.bodyMedium,
          ),
        ),
      ),
      body: Obx(() {
        return Stack(
          children: [
            Positioned.fill(
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .start,
                    children: [
                      Gap(5.h),
                      StepProgressIndicator(
                        totalSteps: 3,
                        currentStep: controller.currentStep + 1,
                        selectedColor: ConstantColors.secondaryButtonColor,
                        unselectedColor: ConstantColors.primaryButtonColor,
                      ),
                      Gap(10.h),
                      Text(
                        controller.currentStep == 2
                            ? ConstantStrings.uploadImages
                            : ConstantStrings.fillInDetails,
                        style: context.textTheme.bodyMedium,
                      ).paddingSymmetric(horizontal: 5.w),
                      Gap(55.h),
                      IndexedStack(
                        index: controller.currentStep,
                        children: [
                          // title,price, years , bike name
                          PartOne(controller: controller),
                          // description, location ,
                          PartTwo(controller: controller),
                          // images upload
                          PartThree(controller: controller),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (controller.isLoading)
              Positioned.fill(
                child: Container(
                  color: ConstantColors.backgroundColor,
                  child: Center(
                    child: Container(
                      padding: .symmetric(horizontal: 18.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        color: ConstantColors.backgroundColor,
                        borderRadius: .circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: ConstantColors.backgroundColor,
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          const CircularProgressIndicator(
                            strokeWidth: 3,
                            color: ConstantColors.primaryButtonColor,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            ConstantStrings.processing,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
