import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/utils/validators.dart';

class CommanTextFormField extends StatelessWidget {
  const CommanTextFormField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    required this.maxLines,
    this.controller,
    this.onFieldSubmitted,
    this.onChanged,
    this.focusNode,
  });
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      scrollPadding: .all(0),
      controller: controller,
      minLines: 1,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: context.textTheme.bodySmall,
      validator: Validators.validateNull,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.7.r),
          borderSide: BorderSide(color: ConstantColors.primaryTextColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.7.r),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.7.r),
          borderSide: BorderSide(color: ConstantColors.primaryTextColor),
        ),
        contentPadding: .symmetric(horizontal: 5.w, vertical: 1.h),
        hintText: hintText,
        hintStyle: context.textTheme.bodySmall,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.7.r),
          borderSide: BorderSide(color: ConstantColors.primaryTextColor),
        ),
      ),
    );
  }
}
