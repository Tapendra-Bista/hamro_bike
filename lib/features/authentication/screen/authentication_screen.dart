import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:logger/logger.dart';

import '../../../common/constant/constant_strings.dart';
import '../../../common/extensions/extensions_widget.dart';
import '../../../common/widgets/app_logo.dart';
import '../../../routes/routes_name.dart';
import '../widgets/authentication_with_google.dart';

// authentication screen
class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(55.h),
            // logo part
            const AppLogo(),

            Text.rich(
              TextSpan(
                text: ConstantStrings.appDescriptionTitle,
                style: context.appTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: ConstantStrings.appDescriptionBody,
                    style: context.appTextTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: ConstantStrings.appDescriptionSubBody,
                    style: context.appTextTheme.bodyMedium,
                  ),
                ],
              ),
            ).appPaddingOnly(left: 28.w),
            Gap(30.h),
            // bikes Image part
            Image.asset(
              ConstantStrings.registerationLogo,
              width: 0.9.sw,

              fit: BoxFit.contain,
            ),
            Gap(125.h),
            // google part
            const ContinueWithGoogle(),
            Gap(8.h),
            Text.rich(
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(RoutesName.userAgreement);
                    Logger().i("User Agreement and Privacy Policy Tapped");
                  },
                text: ConstantStrings.userAgreement,
                style: context.appTextTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: ConstantStrings.andString,
                    style: context.appTextTheme.bodySmall?.copyWith(),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(RoutesName.privacyPolicy);
                        Logger().i("Privacy Policy Tapped");
                      },
                    text: ConstantStrings.privacyPolicy,
                    style: context.appTextTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ).center(),
          ],
        ).center().appPaddingSymmetric(h: 12.w, v: 10.h),
      ).safe(),
    );
  }
}
