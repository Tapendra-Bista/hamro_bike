import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/constant/constant_strings.dart';
import '../../common/widgets/comman_back_button.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CommanBackButton()),
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
