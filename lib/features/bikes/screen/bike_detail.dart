import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../common/constant/constant_colors.dart';
import '../../../common/widgets/comman_back_button.dart';
import '../../create_post/model/create_post_model.dart';
import '../controller/bikes_controller.dart';
import '../widgets/bike_chat.dart';
import '../widgets/bike_details.dart';
import '../widgets/bikes_carousel.dart';
import '../widgets/bikes_title_and_description.dart';

class BikeDetail extends StatefulWidget {
  const BikeDetail({super.key, required this.bike});
  final CreatePostModel bike;

  @override
  State<BikeDetail> createState() => _BikeDetailState();
}

class _BikeDetailState extends State<BikeDetail> {
  late BikesController _bikesController;

  @override
  void initState() {
    super.initState();
    _bikesController = Get.find<BikesController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const CommanBackButton(),
        title: Text(
          widget.bike.vehicleName,
          style: context.textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        actions: [
          // Favorite Button
          StreamBuilder<bool>(
            stream: _bikesController.isFavorite(widget.bike.postId),
            builder: (context, snapshot) {
              final isFav = snapshot.data ?? false;
              return IconButton(
                onPressed: () {
                  if (isFav) {
                    _bikesController.removeFromFavorites(widget.bike.postId);
                  } else {
                    _bikesController.addToFavorites(widget.bike.postId);
                  }
                },
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav
                      ? Colors.red
                      : ConstantColors.secondaryButtonColor,
                ),
              );
            },
          ),

          // More Options Menu
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(5),
              // image
              BikesCarousel(bike: widget.bike),
              Gap(10.h),
              // title and description
              BikesTitleAndDescription(bike: widget.bike),
              Gap(20.h),
              // chat button to chat with seller
              BikeChat(bike: widget.bike),
              Gap(10.h),
              // bike details
              BikeDetails(bike: widget.bike),
              Gap(20.h),

              // comments section
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
