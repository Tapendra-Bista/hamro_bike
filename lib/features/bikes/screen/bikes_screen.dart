import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/features/bikes/controller/bikes_controller.dart';
import 'package:hamro_bike/features/bikes/screen/bike_detail.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/bikes_app_bar.dart';
import '../widgets/bikes_carousel.dart';
import '../widgets/bikes_empty_text.dart';
import '../widgets/bikes_error_text.dart';
import '../widgets/bikes_like_and_comment.dart';
import '../widgets/bikes_poster.dart';
import '../widgets/bikes_title_and_description.dart';

// <Feature><WidgetType> While naming the screen sub widgets, use the feature name as prefix
class BikesScreen extends StatefulWidget {
  const BikesScreen({super.key});
  // BIKES SCREEN TO SHOW LIST OF BIKES
  @override
  State<BikesScreen> createState() => _BikesScreenState();
}

class _BikesScreenState extends State<BikesScreen> {
  late BikesController bikesController;
  @override
  void initState() {
    bikesController = Get.put(BikesController());
    // Defer fetching until after the first frame so controller Rx updates
    // don't run during the initial build and cause 'setState during build'.
    WidgetsBinding.instance.addPostFrameCallback((_) => fetch());
    super.initState();
  }

  void fetch() async {
    // First load bikes list, then fetch poster profiles for the loaded bikes.
    await bikesController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Skeletonizer(
            enabled: bikesController.isLoading,
            child: bikesController.errorMessage.isNotEmpty
                ? BikesErrorText(
                    bikesController: bikesController,
                  ) // when error occurs
                : CustomScrollView(
                    slivers: [
                      const BikesAppBar(), // appbar
                      SliverToBoxAdapter(child: Gap(30.h)),

                      bikesController.bikesList.isEmpty
                          ? const BikesEmptyText() // when no bikes available
                          : SliverList.builder(
                              itemCount: bikesController.bikesList.length,
                              itemBuilder: (context, index) {
                                final bike = bikesController.bikesList[index];
                                if (bike.uId.isEmpty) {
                                  return const SizedBox.shrink();
                                }
                                final bikePoster =
                                    bikesController
                                        .posterProfileMap[bikesController
                                        .bikesList[index]
                                        .uId];

                                return RepaintBoundary(
                                  child: Container(
                                    margin: .only(bottom: 6.h),

                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border(
                                        bottom: BorderSide(
                                          color: ConstantColors.dividersColor,
                                          width: 0.9,
                                        ),
                                        top: BorderSide(
                                          color: ConstantColors.dividersColor,
                                          width: 0.9,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: .start,
                                      crossAxisAlignment: .start,
                                      children: [
                                        Gap(5.h),
                                        if (bikePoster != null)
                                          BikesPoster(
                                            bike: bike,
                                            bikePoster: bikePoster,
                                          ),
                                        Gap(15.h),
                                        // title and description
                                        BikesTitleAndDescription(bike: bike),
                                        Gap(2.h),
                                        // image carousel
                                        InkWell(
                                          onTap: () => Get.to(
                                            () => BikeDetail(bike: bike),
                                          ),
                                          child: BikesCarousel(bike: bike),
                                        ),

                                        Gap(5.h),
                                        // like and comment
                                        BikesLikeAndComment(
                                          controller: bikesController,
                                          bike: bike,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
