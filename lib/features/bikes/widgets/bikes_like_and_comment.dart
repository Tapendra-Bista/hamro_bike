import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/common/extensions/extensions_widget.dart';
import 'package:hamro_bike/common/utils/like_format.dart';
import 'package:hamro_bike/features/bikes/controller/bikes_controller.dart';
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
    return Row(
      mainAxisAlignment: .start,
      spacing: 5.w,
      children: [
        StreamBuilder(
          stream: controller.streamLikes(bike.postId),
          builder: (context, snapshot) {
            int likeCount = 0;

            if (snapshot.hasData) {
              likeCount = snapshot.data!.likeId.length;
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
                    if (snapshot.data != null) {
                      if (snapshot.data!.likeId.contains(bike.uId)) {
                        controller.removeLike(bike.postId);
                      } else {
                        controller.addLike(bike.postId);
                      }
                    } else {
                      controller.addLike(bike.postId);
                    }
                  },
                  icon: Icon(
                    snapshot.data == null
                        ? Iconsax.heart_copy
                        : snapshot.data!.likeId.contains(bike.uId)
                        ? Iconsax.heart
                        : Iconsax.heart_copy,
                    color: snapshot.data == null
                        ? null
                        : snapshot.data!.likeId.contains(bike.uId)
                        ? Colors.red
                        : null,
                  ),
                ),
              ],
            );
          },
        ),

        Row(
          spacing: 2.w,
          children: [
            Text('5k', style: context.appTextTheme.bodySmall),
            IconButton(
              style: context.iconButtonTheme.style!.copyWith(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Colors.transparent,
                ),
              ),
              onPressed: () {},
              icon: Icon(CupertinoIcons.chat_bubble),
            ),
          ],
        ),
      ],
    ).appPaddingSymmetric(h: 10.w);
  }
}
