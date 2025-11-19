import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../common/extensions/extensions_buildcontext.dart';
import '../../create_post/model/create_post_model.dart';
import '../widgets/bike_chat.dart';
import '../widgets/bike_details.dart';
import '../widgets/bikes_carousel.dart';
import '../widgets/bikes_title_and_description.dart';

class BikeDetail extends StatelessWidget {
  const BikeDetail({super.key, required this.bike});
  final CreatePostModel bike;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          style: context.iconButtonTheme.style,
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left_copy),
        ),
        title: Text(
          bike.vehicleName,
          style: context.textTheme.bodyMedium,
          overflow: .ellipsis,
          maxLines: 1,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              Gap(5),
              // image
              BikesCarousel(bike: bike),
              Gap(10.h),
              // title and description
              BikesTitleAndDescription(bike: bike),
              Gap(20.h),
              // chat button to chat with seller
              BikeChat(),
              Gap(10.h),
              // bike details
              BikeDetails(bike: bike),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
