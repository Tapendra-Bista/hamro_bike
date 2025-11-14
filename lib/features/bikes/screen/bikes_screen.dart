import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/features/bikes/controller/bikes_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../common/widgets/common_divider.dart';
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
                      BikesAppBar(), // appbar
                      SliverToBoxAdapter(child: Gap(30.h)),

                      bikesController.bikesList.isEmpty
                          ? BikesEmptyText() // when no bikes available
                          : SliverList.builder(
                              itemCount: bikesController.bikesList.length,
                              itemBuilder: (context, index) {
                                final bike = bikesController.bikesList[index];
                                final bikePoster =
                                    bikesController.posterProfileMap[bike.uId];
                                return Column(
                                  mainAxisAlignment: .start,
                                  crossAxisAlignment: .start,
                                  children: [
                                    Gap(15.h),
                                    BikesPoster(
                                      bike: bike,
                                      bikePoster: bikePoster!,
                                    ),

                                    Gap(15.h),
                                    // title and description
                                    BikesTitleAndDescription(bike: bike),

                                    CommanDivider(),
                                    Gap(15.h),
                                    // image carousel
                                    BikesCarousel(bike: bike),
                                    Gap(5.h),
                                    // like and comment
                                    BikesLikeAndComment(),
                                    CommanDivider(),
                                    Gap(30.h),
                                  ],
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
