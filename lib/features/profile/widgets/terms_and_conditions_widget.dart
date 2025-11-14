import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../routes/routes_name.dart';

// terms and conditions widget
class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 11.w),
      child: Container(
        padding: .all(5.w),
        width: double.infinity,

        decoration: BoxDecoration(
          color: ConstantColors.containerColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                padding: .all(12.r),
                decoration: BoxDecoration(
                  color: Colors.pink.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Iconsax.star_copy, color: Colors.pink),
              ),
              title: Text(
                ConstantStrings.yourAds,
                style: context.textTheme.bodyMedium,
              ),
              subtitle: Text(
                ConstantStrings.manageYourAds,
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
              leading: Container(
                padding: .all(12.r),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Iconsax.heart_copy, color: Colors.red),
              ),
              title: Text(
                ConstantStrings.favourites,
                style: context.textTheme.bodyMedium,
              ),
              subtitle: Text(
                ConstantStrings.yourSavedItems,
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
              onTap: () => Get.toNamed(RoutesName.termsAndConditions),
              leading: Container(
                padding: .all(12.r),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Iconsax.document_text_copy, color: Colors.blue),
              ),
              title: Text(
                ConstantStrings.termsAndConditions,
                style: context.textTheme.bodyMedium,
              ),
              subtitle: Text(
                ConstantStrings.legalInformation,
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
              onTap: () => Get.toNamed(RoutesName.privacyPolicy),
              trailing: SizedBox(
                width: 10.w,
                child: Icon(
                  Icons.chevron_right,
                  size: 30.sp,
                  color: ConstantColors.secondaryTextColor,
                ),
              ),
              leading: Container(
                padding: .all(12.r),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Iconsax.lock_copy, color: Colors.orange),
              ),
              title: Text(
                ConstantStrings.privacyPolicy,
                style: context.textTheme.bodyMedium,
              ),
              subtitle: Text(
                ConstantStrings.protectingYourPrivacy,
                style: context.textTheme.bodySmall,
              ),
            ),

            ListTile(
              trailing: SizedBox(
                width: 10.w,
                child: Icon(
                  Icons.chevron_right,
                  size: 30.sp,
                  color: ConstantColors.secondaryTextColor,
                ),
              ),
              leading: Container(
                padding: .all(12.r),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Iconsax.refresh_copy, color: Colors.green),
              ),
              title: Text(
                ConstantStrings.checkForUpdates,
                style: context.textTheme.bodyMedium,
              ),
              subtitle: Text(
                ConstantStrings.keepYourAppUpdated,
                style: context.textTheme.bodySmall,
              ),
            ),
            ListTile(
              subtitle: Text(
                ConstantStrings.permanentlyDeleteAccount,
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
                padding: .all(12.r),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Iconsax.profile_delete_copy, color: Colors.red),
              ),
              title: Text(
                ConstantStrings.deleteAccount,
                style: context.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
