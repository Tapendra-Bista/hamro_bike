import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/common/widgets/post_created_date.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';

import '../../profile/model/profile_model.dart';

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
            onPressed: () => showMenu(
              elevation: 0,
              color: ConstantColors.dividersColor,
              context: context,
              position: .fromLTRB(100.w, 150.h, 0, 0),
              items: [
                PopupMenuItem(
                  value: 'report',
                  child: Text(
                    'Report Post',
                    style: context.appTextTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),

                PopupMenuItem(
                  value: 'block',
                  child: Text(
                    'Block User',
                    style: context.appTextTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),

                PopupMenuItem(
                  value: 'favourite',
                  child: Text(
                    'Favourite',
                    style: context.appTextTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
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
          '${PostCreatedDate.postCreatedDate(bike.postDate)} ago',
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
}
