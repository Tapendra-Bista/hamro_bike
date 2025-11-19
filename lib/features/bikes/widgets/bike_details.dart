import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';

import '../../../common/constant/constant_colors.dart';
import '../../create_post/model/create_post_model.dart';

class BikeDetails extends StatelessWidget {
  const BikeDetails({super.key, required this.bike});

  final CreatePostModel bike;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: .all(color: ConstantColors.dividersColor, width: 1),
      children: [
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Text(
                ConstantStrings.vehicleName,
                style: context.textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Text(
                bike.vehicleName,
                style: context.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Text(
                ConstantStrings.status,
                style: context.textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Text(bike.status, style: context.textTheme.bodyMedium),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Text(
                ConstantStrings.usedDuration,
                style: context.textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Text(
                '${bike.usedDurationInYears}',
                style: context.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Text(
                ConstantStrings.price,
                style: context.textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Text(
                'Rs. ${bike.price.toString()}',
                style: context.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Text(
                ConstantStrings.location,
                style: context.textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Text(bike.location, style: context.textTheme.bodyMedium),
            ),
          ],
        ),
      ],
    ).paddingSymmetric(horizontal: 8.w);
  }
}
