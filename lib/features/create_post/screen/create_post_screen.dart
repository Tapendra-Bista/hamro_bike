import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/common/widgets/loading.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          style: context.iconButtonTheme.style,
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left_copy),
        ),
        title: Text(
          ConstantStrings.createPostForAds,
          style: context.textTheme.bodyMedium,
        ),
      ),
      body: Obx(() {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (controller.isLoading) {
            loading(context, 'Processing');
          } else {
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
          }
        });

        return Stack(
          children: [
            Positioned.fill(
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          PartOne(controller: controller),
                          PartTwo(controller: controller),
                          PartThree(controller: controller),
                        ],
                      ),
                    ],
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
