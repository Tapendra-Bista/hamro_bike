import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/common/extensions/extensions_widget.dart';
import 'package:hamro_bike/common/utils/like_format.dart';
import 'package:hamro_bike/features/bikes/controller/bikes_controller.dart';
import 'package:hamro_bike/features/bikes/widgets/comments_section.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BikesLikeAndComment extends StatelessWidget {
  const BikesLikeAndComment({
    super.key,
    required this.controller,
    required this.bike,
  });
  final BikesController controller;
  final CreatePostModel bike;
  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Row(
      mainAxisAlignment: .start,
      spacing: 5.w,
      children: [
        StreamBuilder(
          stream: controller.streamLikes(bike.postId),
          builder: (context, snapshot) {
            int likeCount = 0;
            bool isLiked = false;

            if (snapshot.hasData && snapshot.data != null) {
              likeCount = snapshot.data!.likeId.length;
              isLiked = snapshot.data!.likeId.contains(currentUserId);
            }

            return Row(
              spacing: 2.w,
              children: [
                Text(
                  likeCount == 0 ? ' ' : LikeFormat.formatLikes(likeCount),
                  style: context.appTextTheme.bodySmall,
                ),
                IconButton(
                  style: context.iconButtonTheme.style!.copyWith(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Colors.transparent,
                    ),
                  ),
                  onPressed: () {
                    if (isLiked) {
                      controller.removeLike(bike.postId);
                    } else {
                      controller.addLike(bike.postId);
                    }
                  },
                  icon: Icon(
                    isLiked ? Iconsax.heart : Iconsax.heart_copy,
                    color: isLiked ? Colors.red : null,
                  ),
                ),
              ],
            );
          },
        ),

        StreamBuilder<List<Map<String, dynamic>>>(
          stream: controller.getComments(bike.postId),
          builder: (context, snapshot) {
            int commentCount = 0;
            if (snapshot.hasData) {
              commentCount = snapshot.data!.length;
            }
            return Row(
              spacing: 2.w,
              children: [
                Text(
                  commentCount == 0 ? ' ' : '$commentCount',
                  style: context.appTextTheme.bodySmall,
                ),
                IconButton(
                  style: context.iconButtonTheme.style!.copyWith(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Colors.transparent,
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: Get.context!,
                      isScrollControlled: true,
                      backgroundColor: ConstantColors.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.r),
                        ),
                      ),
                      builder: (modalContext) => DraggableScrollableSheet(
                        initialChildSize: 0.7,
                        minChildSize: 0.5,
                        maxChildSize: 0.95,
                        expand: false,
                        builder: (sheetContext, scrollController) => Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              modalContext,
                            ).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.r),
                            ),
                          ),
                          child: Column(
                            children: [
                              // Handle bar
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 12.h),
                                width: 40.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: ConstantColors.secondaryTextColor,
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),
                              // Comments section
                              Expanded(
                                child: CommentsSection(
                                  bike: bike,
                                  controller: controller,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(CupertinoIcons.chat_bubble),
                ),
              ],
            );
          },
        ),
      ],
    ).appPaddingSymmetric(h: 10.w);
  }
}
