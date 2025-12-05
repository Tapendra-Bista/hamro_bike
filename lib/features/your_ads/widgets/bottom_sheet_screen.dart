import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/common/extensions/extensions_widget.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../bikes/widgets/bikes_carousel.dart';
import '../../bikes/widgets/bikes_title_and_description.dart';

class BottomSheetScreen extends StatelessWidget {
  const BottomSheetScreen({super.key, required this.ad});

  final CreatePostModel ad;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: .maxFinite,
        padding: .all(20.w),
        decoration: BoxDecoration(
          borderRadius: .circular(25.r),
          color: ConstantColors.dividersColor,
        ),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .max,
          spacing: 15.h,
          children: [
            Divider(
              color: Colors.white,
              thickness: 4,
              radius: .circular(8.r),
            ).width(50.w).center(),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  'Ads Details',
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: .bold,
                    color: ConstantColors.secondaryButtonColor,
                  ),
                ),
                IconButton(
                  style: context.iconButtonTheme.style!.copyWith(
                    fixedSize: WidgetStatePropertyAll(Size(30, 30)),
                  ),
                  onPressed: () => Get.back(),
                  icon: Icon(Iconsax.close_circle_copy),
                ),
              ],
            ),
            BikesCarousel(bike: ad).rounded(8.r),
            BikesTitleAndDescription(bike: ad),
            SizedBox(height: 30.h),
            Text(
              'Ads Insight',
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: .bold,
                color: ConstantColors.secondaryButtonColor,
              ),
            ),
            Table(
              border: .all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1,
              ),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: .symmetric(vertical: 8.h, horizontal: 4.w),
                      child: Text(
                        'Expiring in',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: .symmetric(vertical: 8.h, horizontal: 4.w),
                      child: Text(
                        '7 days',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: .symmetric(vertical: 8.h, horizontal: 4.w),
                      child: Text(
                        'Total Views',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: .symmetric(vertical: 8.h, horizontal: 4.w),
                      child: Text('1000', style: context.textTheme.bodyMedium),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: .symmetric(vertical: 8.h, horizontal: 4.w),
                      child: Text(
                        'Total Inquiries',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: .symmetric(vertical: 8.h, horizontal: 4.w),
                      child: Text('150', style: context.textTheme.bodyMedium),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: .symmetric(vertical: 8.h, horizontal: 4.w),
                      child: Text(
                        'Total  Likes',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: .symmetric(vertical: 8.h, horizontal: 4.w),
                      child: Text('75', style: context.textTheme.bodyMedium),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: .symmetric(vertical: 8.h, horizontal: 4.w),
                      child: Text(
                        'Total  Comments',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: .symmetric(vertical: 8.h, horizontal: 4.w),
                      child: Text('75', style: context.textTheme.bodyMedium),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: .symmetric(vertical: 8.h, horizontal: 4.w),
                      child: Text(
                        ConstantStrings.status,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: .symmetric(vertical: 8.h, horizontal: 4.w),
                      child: Text(
                        ad.status,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Row(
                  spacing: 5.w,
                  children: [
                    Text(
                      'Mark as Sold : ',
                      style: context.textTheme.bodyMedium,
                    ),
                    IconButton(
                      style: context.iconButtonTheme.style!.copyWith(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.green.withValues(alpha: 0.1),
                        ),
                      ),

                      onPressed: () {},
                      icon: Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 5.w,
                  children: [
                    Text('Delete : ', style: context.textTheme.bodyMedium),
                    IconButton(
                      style: context.iconButtonTheme.style!.copyWith(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.red.withValues(alpha: 0.1),
                        ),
                      ),
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
