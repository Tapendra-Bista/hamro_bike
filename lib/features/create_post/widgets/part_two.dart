import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';

import '../../../common/widgets/comman_textformfield.dart';
import '../controller/create_post_controller.dart';

class PartTwo extends StatefulWidget {
  const PartTwo({super.key, required this.controller});

  final CreatePostController controller;
  @override
  State<PartTwo> createState() => _PartTwoState();
}

class _PartTwoState extends State<PartTwo> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController usedDurationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode locationFocusNode = FocusNode();
  final FocusNode usedDurationFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    locationController.dispose();
    usedDurationController.dispose();
    descriptionController.dispose();
    locationFocusNode.dispose();
    usedDurationFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Location'),
          Gap(10.h),
          CommanTextFormField(
            focusNode: locationFocusNode,
            onChanged: (value) => widget.controller.location = value.trim(),
            onFieldSubmitted: (value) {
              widget.controller.location = value.trim();
              usedDurationFocusNode.requestFocus();
              locationFocusNode.unfocus();
            },
            hintText: 'Enter location',
            keyboardType: TextInputType.text,
            maxLines: 6,
          ),
          Gap(35.h),
          Text('Used Duration in Years'),

          Gap(10.h),
          CommanTextFormField(
            focusNode: usedDurationFocusNode,
            onChanged: (value) => widget.controller.usedDurationInYears =
                double.tryParse(value.trim()) ?? 0,
            onFieldSubmitted: (value) {
              widget.controller.usedDurationInYears =
                  double.tryParse(value.trim()) ?? 0;

              usedDurationFocusNode.unfocus();
            },
            hintText: 'Enter years',
            keyboardType: TextInputType.number,
            maxLines: 1,
          ),
          Gap(35.h),
          Text('Description'),

          Gap(10.h),
          CommanTextFormField(
            focusNode: descriptionFocusNode,
            onChanged: (value) => widget.controller.description = value.trim(),
            onFieldSubmitted: (value) {
              widget.controller.description = value.trim();
              if (formKey.currentState!.validate()) {
                widget.controller.currentStep = 2;
              }
              descriptionFocusNode.unfocus();
            },
            hintText: 'Enter description',
            keyboardType: TextInputType.text,
            maxLines: 8,
          ),

          Gap(55.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: context.iconButtonTheme.style!.copyWith(
                  fixedSize: WidgetStatePropertyAll(Size(150.w, 35.h)),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                  ),
                ),
                onPressed: () => widget.controller.currentStep = 0,
                child: Text("Previous", style: context.textTheme.bodyMedium),
              ),
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
                    widget.controller.currentStep = 2;
                  }
                },
                child: Text("Next", style: context.textTheme.bodyMedium),
              ),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 12.w, vertical: 10.h),
    );
  }
}
