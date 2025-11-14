import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/extensions/extensions_widget.dart';
import '../../../common/constant/constant_colors.dart';
import '../../../common/constant/constant_strings.dart';
import '../widgets/connnect_with_us_widget.dart';
import '../widgets/profile_image_widget.dart';
import '../widgets/terms_and_conditions_widget.dart';
import '../widgets/version_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantColors.primaryButtonColor,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 3.h),
          child: Divider(
            color: ConstantColors.dividersColor,
            height: 1.h,
            thickness: 1.h,
          ),
        ),
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          ConstantStrings.profileTitle,
          style: context.textTheme.bodyMedium,
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          spacing: 25.h,
          children: [
            ProfileImage(),
            // terms and conditions widget
            TermsAndConditions(),
            ConnectWithUs(),
            // app version widget
            AppVersion(),
            Gap(10.h),
          ],
        ).safe(),
      ),
    );
  }
}
