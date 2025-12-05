import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/widgets/comman_back_button.dart';
import 'package:hamro_bike/features/bikes/controller/bikes_controller.dart';
import 'package:hamro_bike/features/bikes/screen/bike_detail.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
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
        leading: const CommanBackButton(),
        centerTitle: true,
        title: Text(
          'My Favorites',
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _bikesController.getFavoriteBikes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: ConstantColors.primaryButtonColor,
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64.sp,
                    color: ConstantColors.secondaryTextColor,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No favorites yet',
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: ConstantColors.secondaryTextColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Start adding bikes to your favorites!',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: ConstantColors.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            );
          }

          final favoriteBikes = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(12.w),
            itemCount: favoriteBikes.length,
            itemBuilder: (context, index) {
              final bike = favoriteBikes[index];
              return RepaintBoundary(
                child: Card(
                  margin: EdgeInsets.only(bottom: 12.h),
                  color: ConstantColors.containerColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => BikeDetail(bike: bike));
                    },
                    borderRadius: BorderRadius.circular(12.r),
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: CachedNetworkImage(
                              imageUrl: bike.imageUrls.first,
                              width: 100.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[800],
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.w,
                                    color: ConstantColors.primaryButtonColor,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[800],
                                child: const Icon(Icons.error),
                              ),
                            ),
                          ),

                          SizedBox(width: 12.w),

                          // Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bike.title,
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: ConstantColors.secondaryButtonColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  bike.vehicleName,
                                  style: context.textTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 14.sp,
                                      color: ConstantColors.secondaryTextColor,
                                    ),
                                    SizedBox(width: 4.w),
                                    Expanded(
                                      child: Text(
                                        bike.location,
                                        style: context.textTheme.bodySmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'NPR ${bike.price.toStringAsFixed(0)}',
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: ConstantColors.primaryButtonColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Remove from favorites button
                          StreamBuilder<bool>(
                            stream: _bikesController.isFavorite(bike.postId),
                            builder: (context, snapshot) {
                              return IconButton(
                                onPressed: () {
                                  _bikesController.removeFromFavorites(
                                    bike.postId,
                                  );
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 24.sp,
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
            },
          );
        },
      ),
    );
  }
}
