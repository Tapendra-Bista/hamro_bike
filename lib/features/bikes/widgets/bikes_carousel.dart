import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';

class BikesCarousel extends StatelessWidget {
  const BikesCarousel({super.key, required this.bike});
  final CreatePostModel bike;

  @override
  Widget build(BuildContext context) {
    return Hero(
      createRectTween: (begin, end) => MaterialRectCenterArcTween(
        begin: begin,
        end: end,
      ),
      tag: bike.postId,
      child: Material(
        child: FlutterCarousel(
          items: bike.imageUrls
              .map(
                (path) => CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: path,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      SizedBox.shrink(),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    size: 50.sp,
                    color: ConstantColors.accentColor,
                  ),
                ).paddingSymmetric(horizontal: 2.w),
              )
              .toList(),
          options: FlutterCarouselOptions(
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            floatingIndicator: true,
            indicatorMargin: 1.r,

            showIndicator: true,
          ),
        ),
      ),
    );
  }
}
