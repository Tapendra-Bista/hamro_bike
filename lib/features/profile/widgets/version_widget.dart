import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';

import '../../../common/constant/constant_strings.dart';

// app version widget
class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 11.w),
      child: Container(
        padding: .all(18.w),
        width: double.infinity,

        decoration: BoxDecoration(
          color: ConstantColors.containerColor,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Center(
          child: Text(
            ConstantStrings.appVersionString,
            style: context.textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
