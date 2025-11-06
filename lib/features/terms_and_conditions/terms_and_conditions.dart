import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../common/constant/constant_strings.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          style: context.iconButtonTheme.style,
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left_copy),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Text(
            ConstantStrings.termsAndConditionsDescription,
            style: context.textTheme.bodyMedium,
          ).paddingSymmetric(horizontal: 12.w, vertical: 8.h),
        ),
      ),
    );
  }
}
