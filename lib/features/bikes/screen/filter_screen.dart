import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:hamro_bike/common/widgets/comman_back_button.dart';
import 'package:hamro_bike/features/bikes/controller/bikes_controller.dart';
import 'package:hamro_bike/features/bikes/controller/filter_controller.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bikesController = Get.find<BikesController>();
    final filterController = Get.put(FilterController());

    return Scaffold(
      appBar: AppBar(
        leading: const CommanBackButton(),
        title: Text(
          FilterStrings.filterBikes,
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => filterController.resetFilters(),
            child: Text(
              FilterStrings.reset,
              style: context.textTheme.bodyMedium!.copyWith(
                color: ConstantColors.primaryButtonColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price Range Filter
            Text(
              FilterStrings.priceRange,
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: ConstantColors.secondaryButtonColor,
              ),
            ),
            SizedBox(height: 8.h),
            Obx(
              () => RangeSlider(
                values: filterController.priceRange.value,
                min: 0,
                max: 1000000,
                divisions: 100,
                activeColor: ConstantColors.primaryButtonColor,
                inactiveColor: ConstantColors.containerColor,
                labels: RangeLabels(
                  '${FilterStrings.npr} ${filterController.priceRange.value.start.toInt()}',
                  '${FilterStrings.npr} ${filterController.priceRange.value.end.toInt()}',
                ),
                onChanged: (values) =>
                    filterController.updatePriceRange(values),
              ),
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${FilterStrings.npr} ${filterController.priceRange.value.start.toInt()}',
                    style: context.textTheme.bodySmall,
                  ),
                  Text(
                    '${FilterStrings.npr} ${filterController.priceRange.value.end.toInt()}',
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Location Filter
            Text(
              FilterStrings.location,
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: ConstantColors.secondaryButtonColor,
              ),
            ),
            SizedBox(height: 8.h),
            Obx(
              () => Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: ConstantColors.containerColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: DropdownButton<String>(
                  value: filterController.selectedLocation.value,
                  isExpanded: true,
                  underline: const SizedBox(),
                  dropdownColor: ConstantColors.dividersColor,
                  style: context.textTheme.bodyMedium,
                  items: filterController.locations.map((location) {
                    return DropdownMenuItem(
                      value: location,
                      child: Text(location),
                    );
                  }).toList(),
                  onChanged: (value) => filterController.updateLocation(value!),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Status Filter
            Text(
              FilterStrings.statusFilter,
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: ConstantColors.secondaryButtonColor,
              ),
            ),
            SizedBox(height: 8.h),
            Obx(
              () => Wrap(
                spacing: 8.w,
                children: filterController.statusOptions.map((status) {
                  final isSelected =
                      filterController.selectedStatus.value == status;
                  return ChoiceChip(
                    label: Text(status),
                    selected: isSelected,
                    onSelected: (selected) =>
                        filterController.updateStatus(status),
                    selectedColor: ConstantColors.primaryButtonColor,
                    backgroundColor: ConstantColors.containerColor,
                    labelStyle: context.textTheme.bodySmall!.copyWith(
                      color: isSelected ? Colors.white : null,
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 24.h),

            // Used Duration Filter
            Text(
              FilterStrings.maximumUsedDuration,
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: ConstantColors.secondaryButtonColor,
              ),
            ),
            SizedBox(height: 8.h),
            Obx(
              () => Slider(
                value: filterController.maxUsedYears.value,
                min: 0,
                max: 20,
                divisions: 20,
                activeColor: ConstantColors.primaryButtonColor,
                inactiveColor: ConstantColors.containerColor,
                label:
                    '${filterController.maxUsedYears.value.toInt()} ${FilterStrings.years}',
                onChanged: (value) =>
                    filterController.updateMaxUsedYears(value),
              ),
            ),
            Obx(
              () => Text(
                '${FilterStrings.upToYears} ${filterController.maxUsedYears.value.toInt()} ${FilterStrings.years}',
                style: context.textTheme.bodySmall,
              ),
            ),

            SizedBox(height: 32.h),

            // Apply Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  final filtered = filterController.applyFilters(
                    bikesController.bikesList,
                  );
                  Get.back(result: filtered);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ConstantColors.primaryButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  FilterStrings.applyFilters,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
