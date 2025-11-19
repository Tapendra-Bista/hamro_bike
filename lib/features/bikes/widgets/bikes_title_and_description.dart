import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';

class BikesTitleAndDescription extends StatelessWidget {
  const BikesTitleAndDescription({super.key, required this.bike});

  final CreatePostModel bike;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(vertical: 2.h),
      decoration: BoxDecoration(color: ConstantColors.containerColor.withValues(alpha: 0.16)),
      child: ListTile(
        contentPadding: .symmetric(vertical: 0.h, horizontal: 10.w),
        dense: true,
        minTileHeight: 0,
        minLeadingWidth: 0,
        minVerticalPadding: 0,
        title: Text(
          bike.title,
          style: context.appTextTheme.bodyMedium!.copyWith(fontSize: 22.sp),
          maxLines: 1,
          overflow: .ellipsis,
        ),
        subtitle: Text(
          bike.description,
          style: context.appTextTheme.bodySmall,
          maxLines: 3,
          overflow: .ellipsis,
        ),
      ),
    );
  }
}
