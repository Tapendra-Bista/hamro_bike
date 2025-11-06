import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../constant/constant_colors.dart';

SnackbarController snackbar(String message, Color color) => Get.snackbar(
  '',
  '',
  backgroundColor: color,
  colorText: Colors.white,
  snackPosition: SnackPosition.TOP,
  snackStyle: SnackStyle.FLOATING,
  padding: EdgeInsets.only(bottom: 30.h),
  messageText: Center(
    child: Text(
      message,
      style: TextStyle(color: ConstantColors.primaryTextColor, fontSize: 18.sp),
    ),
  ),
);
