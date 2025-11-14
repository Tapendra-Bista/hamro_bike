import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/common/extensions/extensions_widget.dart';

import '../../../common/widgets/comman_textformfield.dart';
import '../controller/create_post_controller.dart';

class PartOne extends StatefulWidget {
  const PartOne({super.key, required this.controller});
  final CreatePostController controller;

  @override
  State<PartOne> createState() => _PartOneState();
}

class _PartOneState extends State<PartOne> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController vehicleNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode vehicleNameFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    vehicleNameController.dispose();
    priceController.dispose();
    titleFocusNode.dispose();
    vehicleNameFocusNode.dispose();
    priceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          Text(ConstantStrings.title),
          Gap(10.h),
          CommanTextFormField(
            focusNode: titleFocusNode,
            onChanged: (value) => widget.controller.title = value.trim(),
            onFieldSubmitted: (value) {
              widget.controller.title = value.trim();
              titleFocusNode.unfocus();
            },
            hintText: ConstantStrings.titleHint,
            keyboardType: TextInputType.text,
            maxLines: 6,
          ),
          Gap(35.h),
          Text(ConstantStrings.vehicleName),

          Gap(10.h),
          CommanTextFormField(
            focusNode: vehicleNameFocusNode,
            onChanged: (value) => widget.controller.vehicleName = value.trim(),
            onFieldSubmitted: (value) {
              widget.controller.vehicleName = value.trim();
              vehicleNameFocusNode.unfocus();
            },
            hintText: ConstantStrings.vehicleNameHint,
            keyboardType: TextInputType.text,
            maxLines: 1,
          ),
          Gap(35.h),
          Text(ConstantStrings.price),

          Gap(10.h),
          CommanTextFormField(
            focusNode: priceFocusNode,
            onChanged: (value) =>
                widget.controller.price = double.tryParse(value.trim()) ?? 0.0,
            onFieldSubmitted: (value) {
              widget.controller.price = double.tryParse(value.trim()) ?? 0.0;
              if (formKey.currentState!.validate()) {
                widget.controller.currentStep = 1;
              }
              priceFocusNode.unfocus();
            },
            hintText: ConstantStrings.priceHint,
            keyboardType: TextInputType.number,
            maxLines: 1,
          ),

          Gap(55.h),
          ElevatedButton(
            style: context.iconButtonTheme.style!.copyWith(
              fixedSize: WidgetStatePropertyAll(Size(150.w, 35.h)),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.r),
                ),
              ),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                widget.controller.currentStep = 1;
              }
            },
            child: Text(
              ConstantStrings.nextButton,
              style: context.textTheme.bodyMedium,
            ),
          ).center(),
        ],
      ).paddingSymmetric(horizontal: 12.w, vertical: 10.h),
    );
  }
}
