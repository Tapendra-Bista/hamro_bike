import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/features/bikes/screen/bike_detail.dart';
import 'package:hamro_bike/features/search/controller/search_controller.dart'
    as search;

class SearchScreen extends GetView<search.SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Bikes',
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(12.w),
            child: TextField(
              controller: controller.searchTextController,
              onChanged: controller.searchBikes,
              style: context.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Search by title, brand, location...',
                hintStyle: context.textTheme.bodySmall!.copyWith(
                  color: ConstantColors.secondaryTextColor,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: ConstantColors.secondaryButtonColor,
                ),
                suffixIcon: Obx(
                  () => controller.searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: ConstantColors.secondaryTextColor,
                          ),
                          onPressed: controller.clearSearch,
                        )
                      : const SizedBox.shrink(),
                ),
                filled: true,
                fillColor: ConstantColors.containerColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),

          // Sort and Filter Options
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showSortOptions(context),
                    icon: const Icon(Icons.sort),
                    label: const Text('Sort'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ConstantColors.secondaryButtonColor,
                      side: BorderSide(
                        color: ConstantColors.secondaryButtonColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showFilterOptions(context),
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filter'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ConstantColors.secondaryButtonColor,
                      side: BorderSide(
                        color: ConstantColors.secondaryButtonColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Results Count
          Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  controller.isSearching
                      ? '${controller.searchResults.length} results found'
                      : 'Showing ${controller.searchResults.length} bikes',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: ConstantColors.secondaryTextColor,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 8.h),

          // Search Results
          Expanded(
            child: Obx(() {
              if (controller.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ConstantColors.primaryButtonColor,
                  ),
                );
              }

              if (controller.searchResults.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64.sp,
                        color: ConstantColors.secondaryTextColor,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        controller.isSearching
                            ? 'No results found'
                            : 'No bikes available',
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: ConstantColors.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  final bike = controller.searchResults[index];
                  return Card(
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
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: ConstantColors
                                              .secondaryButtonColor,
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
                                        color:
                                            ConstantColors.secondaryTextColor,
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
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              ConstantColors.primaryButtonColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ConstantColors.dividersColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sort By',
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            ListTile(
              leading: const Icon(Icons.arrow_upward),
              title: const Text('Price: Low to High'),
              onTap: () {
                controller.sortByPrice(ascending: true);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_downward),
              title: const Text('Price: High to Low'),
              onTap: () {
                controller.sortByPrice(ascending: false);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.new_releases),
              title: const Text('Newest First'),
              onTap: () {
                controller.sortByDate(newest: true);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Oldest First'),
              onTap: () {
                controller.sortByDate(newest: false);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ConstantColors.dividersColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter By Price',
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            ListTile(
              title: const Text('Under 100,000'),
              onTap: () {
                controller.filterByPriceRange(0, 100000);
                Get.back();
              },
            ),
            ListTile(
              title: const Text('100,000 - 300,000'),
              onTap: () {
                controller.filterByPriceRange(100000, 300000);
                Get.back();
              },
            ),
            ListTile(
              title: const Text('300,000 - 500,000'),
              onTap: () {
                controller.filterByPriceRange(300000, 500000);
                Get.back();
              },
            ),
            ListTile(
              title: const Text('Above 500,000'),
              onTap: () {
                controller.filterByPriceRange(500000, double.infinity);
                Get.back();
              },
            ),
            ListTile(
              title: const Text('Show All'),
              onTap: () {
                controller.searchBikes(controller.searchQuery);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
