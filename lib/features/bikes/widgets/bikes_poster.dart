import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/common/widgets/post_created_date.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';

import '../../profile/model/profile_model.dart';
import '../controller/bikes_controller.dart';

class BikesPoster extends StatelessWidget {
  const BikesPoster({super.key, required this.bike, required this.bikePoster});
  final CreatePostModel bike;
  final ProfileModel bikePoster;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListTile(
        trailing: SizedBox(
          width: 50.w,
          child: IconButton(
            style: context.iconButtonTheme.style!.copyWith(
              backgroundColor: WidgetStatePropertyAll<Color>(
                Colors.transparent,
              ),
            ),

            // menu
            onPressed: () async {
              final menuContext = context;
              final result = await showMenu(
                elevation: 0,
                color: ConstantColors.dividersColor,
                context: menuContext,
                position: .fromLTRB(100.w, 150.h, 0, 0),
                items: [
                  PopupMenuItem(
                    value: 'report',
                    child: Text(
                      'Report Post',
                      style: menuContext.appTextTheme.bodySmall!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'block',
                    child: Text(
                      'Block User',
                      style: menuContext.appTextTheme.bodySmall!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'favourite',
                    child: Text(
                      'Favourite',
                      style: menuContext.appTextTheme.bodySmall!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );

              if (result != null) {
                _handleMenuAction(result);
              }
            },
            icon: Icon(
              Icons.more_horiz_outlined,
              color: ConstantColors.secondaryTextColor,
            ),
          ),
        ),
        contentPadding: .symmetric(vertical: 0.h, horizontal: 10.w),
        dense: true,
        minTileHeight: 0,
        minLeadingWidth: 0,
        minVerticalPadding: 0,
        subtitle: Text(
          '${PostCreatedDate.postCreatedDate(bike.postDate)} ago, ${bike.location}',
          style: context.appTextTheme.bodySmall,
        ),
        title: Text(
          bikePoster.name,
          style: context.appTextTheme.bodyMedium!.copyWith(fontSize: 16.sp),
        ),
        leading: Builder(
          builder: (context) {
            final profileUrl = bikePoster.profile;
            return CircleAvatar(
              radius: 20.r,
              backgroundImage: profileUrl.isNotEmpty
                  ? CachedNetworkImageProvider(profileUrl)
                  : null,
            );
          },
        ),
      ),
    );
  }

  void _handleMenuAction(String action) {
    final controller = Get.find<BikesController>();

    switch (action) {
      case 'report':
        _showReportDialog(controller);
        break;
      case 'block':
        _showBlockDialog(controller);
        break;
      case 'favourite':
        _toggleFavorite(controller);
        break;
    }
  }

  void _showReportDialog(BikesController controller) {
    final reasonController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: ConstantColors.dividersColor,
        title: Text(
          'Report Post',
          style: Get.textTheme.bodyLarge!.copyWith(color: Colors.white),
        ),
        content: TextField(
          controller: reasonController,
          style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter reason for reporting',
            hintStyle: Get.textTheme.bodySmall!.copyWith(color: Colors.white54),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white54),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white54),
            ),
          ),
          TextButton(
            onPressed: () {
              if (reasonController.text.trim().isNotEmpty) {
                controller.reportPost(
                  postId: bike.postId,
                  reason: reasonController.text.trim(),
                );
                Get.back();
              }
            },
            child: Text(
              'Report',
              style: Get.textTheme.bodyMedium!.copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showBlockDialog(BikesController controller) {
    Get.dialog(
      AlertDialog(
        backgroundColor: ConstantColors.dividersColor,
        title: Text(
          'Block User',
          style: Get.textTheme.bodyLarge!.copyWith(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to block ${bikePoster.name}? You won\'t see their posts anymore.',
          style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white54),
            ),
          ),
          TextButton(
            onPressed: () {
              controller.blockUser(bike.uId);
              Get.back();
            },
            child: Text(
              'Block',
              style: Get.textTheme.bodyMedium!.copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleFavorite(BikesController controller) async {
    final isFav = await controller.isFavorite(bike.postId).first;

    if (isFav) {
      await controller.removeFromFavorites(bike.postId);
    } else {
      await controller.addToFavorites(bike.postId);
    }
  }
}
