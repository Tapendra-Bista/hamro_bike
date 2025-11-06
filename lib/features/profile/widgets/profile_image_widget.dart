import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:hamro_bike/common/widgets/loading.dart';
import 'package:hamro_bike/features/profile/controller/profile_controller.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final controller = Get.find<ProfileController>();
  @override
  void initState() {
    controller.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      width: double.infinity,
      decoration: BoxDecoration(color: ConstantColors.primaryButtonColor),
      child: Obx(() {
        // Manage loading dialog based on controller states
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          final showLogout = controller.isLoggingOut;
          final showDelete = controller.isDeletingAccount;
          if ((showLogout || showDelete) && !(Get.isDialogOpen ?? false)) {
            await loading(
              context,
              showDelete
                  ? ConstantStrings.deletingAccount
                  : ConstantStrings.logoutInProgress,
            );
          } else if (!showLogout &&
              !showDelete &&
              (Get.isDialogOpen ?? false)) {
            Get.back();
          }
        });

        final isLoading = controller.shrimmerLoading;
        final profile = controller.userProfile;
        final createdAt = profile?.createdAt;
        final createdText = (createdAt != null)
            ? DateFormat.yMMMd().format(createdAt)
            : '';
        return Skeletonizer(
          enabled: isLoading,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Gap(5.h),
              CircleAvatar(
                radius: 40.r,

                backgroundImage: (profile?.profile.isNotEmpty == true)
                    ? CachedNetworkImageProvider(profile!.profile)
                    : null,
                child: (profile?.profile.isNotEmpty == true)
                    ? null
                    : Icon(Icons.person, size: 30.r, color: Colors.white),
              ),
              Gap(5.h),
              Text(
                profile?.name ?? '',
                style:
                    (Theme.of(context).textTheme.bodyLarge ?? const TextStyle())
                        .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                profile?.email ?? '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              // joined date
              Text(
                "Joined $createdText",
                style: Theme.of(context).textTheme.bodySmall,
              ),

              Gap(25.h),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all<Size>(Size(150.w, 35.h)),
                ),

                onPressed: () => controller.logOut(),
                child: Row(
                  spacing: 12.w,
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      size: 18.r,
                      color: ConstantColors.primaryButtonColor,
                    ),
                    Text(
                      ConstantStrings.logoutButton,
                      style:
                          (Theme.of(context).textTheme.bodyMedium ??
                                  const TextStyle())
                              .copyWith(
                                fontSize: 16.sp,
                                color: ConstantColors.primaryButtonColor,
                              ),
                    ),
                  ],
                ),
              ),
              Gap(5.h),
            ],
          ),
        );
      }),
    );
  }
}
