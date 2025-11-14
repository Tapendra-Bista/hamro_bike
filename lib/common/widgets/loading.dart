import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Avoid extension ambiguity; use Theme.of(context) directly here.
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';

Future<dynamic> loading(BuildContext context, String text) {
  return Get.dialog(
    Dialog(
      child: Container(
        height: 45.h,
        width: 150.w,
        decoration: BoxDecoration(
          color: ConstantColors.backgroundColor,
          borderRadius: BorderRadius.circular(11.r),
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5.w),
            SpinKitThreeBounce(
              color: ConstantColors.secondaryButtonColor,
              size: 20.w,
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
