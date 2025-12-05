import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:hamro_bike/features/your_ads/controller/your_ads_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../common/widgets/comman_back_button.dart';
import '../widgets/custom_listtile.dart';

class YourAdsScreen extends StatefulWidget {
  const YourAdsScreen({super.key});

  @override
  State<YourAdsScreen> createState() => _YourAdsScreenState();
}

class _YourAdsScreenState extends State<YourAdsScreen> {
  late YourAdsController _yourAdsController;
  @override
  void initState() {
    _yourAdsController = Get.find<YourAdsController>();
    _yourAdsController.fetchYourAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommanBackButton(),
        centerTitle: true,
        title: Text(
          ConstantStrings.yourAds,
          style: context.textTheme.bodyMedium,
        ),
      ),
      body: Obx(() {
        if (_yourAdsController.yourAdsList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.post_add_outlined,
                  size: 64.sp,
                  color: ConstantColors.secondaryTextColor,
                ),
                SizedBox(height: 16.h),
                Text(
                  ConstantStrings.noAdsAvailable,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: ConstantColors.secondaryTextColor,
                  ),
                ),
              ],
            ),
          );
        }

        return Skeletonizer(
          enabled: _yourAdsController.isShimmerEnable,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            itemCount: _yourAdsController.yourAdsList.length,
            itemBuilder: (context, index) {
              final ad = _yourAdsController.yourAdsList[index];
              return RepaintBoundary(
                child: Card(
                  color: ConstantColors.containerColor,
                  margin: .only(bottom: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: .only(
                      topRight: .circular(8.r),

                      bottomRight: .circular(8.r),
                    ),
                  ),

                  // custom list tile
                  child: SmoothSlideTile(
                    ad: ad,
                    child: CustomListTile(ad: ad),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
