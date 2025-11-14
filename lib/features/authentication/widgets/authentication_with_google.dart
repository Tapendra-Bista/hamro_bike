import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:hamro_bike/common/extensions/extensions_widget.dart';
import 'package:hamro_bike/common/widgets/loading.dart';
import 'package:logger/logger.dart';

import '../controllers/authentication_controllers.dart';

// google part
class ContinueWithGoogle extends GetView<AuthenticationController> {
  const ContinueWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (controller.isLoading) {
          if (!(Get.isDialogOpen ?? false)) {
            Logger().i("Loading true -> show dialog");
            await loading(context, ConstantStrings.authenticating);
          }
        } else {
          if (Get.isDialogOpen ?? false) {
            Logger().i("Loading false -> close dialog");
            Get.back(); // Close the loading dialog safely
          }
        }
      });

      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            controller.isLoading
                ? ConstantColors.backgroundColor
                : ConstantColors.primaryButtonColor,
          ),

          foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
          fixedSize: WidgetStateProperty.all<Size>(Size(300.w, 40.h)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
            ),
          ),
        ),
        onPressed: () async {
          if (controller.isLoading) return;
          await controller.continueWithGoogle();
          Logger().i("Google Sign-In Pressing");
        },
        child: Row(
          children: [
            Image.asset(ConstantStrings.googleLogo, width: 28.w, height: 28.h),
            Gap(20.w),
            Text(
              ConstantStrings.continueWithGoogle,
              style: context.textTheme.bodyLarge,
            ),
          ],
        ),
      ).center();
    });
  }
}
