import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../common/constant/constant_colors.dart';
import '../../../routes/routes_name.dart';

class ConnectWithUs extends StatelessWidget {
  const ConnectWithUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.w),
      child: Container(
        padding: EdgeInsets.all(5.w),
        width: double.infinity,

        decoration: BoxDecoration(
          color: ConstantColors.containerColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: EdgeInsets.only(left: 7.w),
              child: Text(
                ConstantStrings.connectWithUs,
                style: context.textTheme.bodyLarge!.copyWith(fontSize: 22.sp),
              ),
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Iconsax.facebook_copy, color: Colors.blue),
              ),
              title: Text(
              ConstantStrings.facebook,
                style: context.textTheme.bodyMedium,
              ),
              subtitle: Text(
                ConstantStrings.joinOurCommunity,
                style: context.textTheme.bodySmall,
              ),
              trailing: SizedBox(
                width: 10.w,
                child: Icon(
                  Icons.chevron_right,
                  size: 30.sp,
                  color: ConstantColors.secondaryTextColor,
                ),
              ),
            ),

            ListTile(
              subtitle: Text(
                ConstantStrings.followUsOnInstagram,
                style: context.textTheme.bodySmall,
              ),
              trailing: SizedBox(
                width: 10.w,
                child: Icon(
                  Icons.chevron_right,
                  size: 30.sp,
                  color: ConstantColors.secondaryTextColor,
                ),
              ),
              leading: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Iconsax.instagram_copy, color: Colors.redAccent),
              ),
              title: Text(ConstantStrings.instagram, style: context.textTheme.bodyMedium),
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Iconsax.play_copy, color: Colors.greenAccent),
              ),
              title: Text(ConstantStrings.rateUs, style: context.textTheme.bodyMedium),
              subtitle: Text(
              ConstantStrings.helpUsImprove,
                style: context.textTheme.bodySmall,
              ),
              trailing: SizedBox(
                width: 10.w,
                child: Icon(
                  Icons.chevron_right,
                  size: 30.sp,
                  color: ConstantColors.secondaryTextColor,
                ),
              ),
            ),

            ListTile(
              onTap: () => Get.toNamed(RoutesName.aboutUs),
              subtitle: Text(
                ConstantStrings.learnMoreAboutUs,
                style: context.textTheme.bodySmall,
              ),
              trailing: SizedBox(
                width: 10.w,
                child: Icon(
                  Icons.chevron_right,
                  size: 30.sp,
                  color: ConstantColors.secondaryTextColor,
                ),
              ),
              leading: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Iconsax.information_copy, color: Colors.red),
              ),
              title: Text(ConstantStrings.aboutUs, style: context.textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
