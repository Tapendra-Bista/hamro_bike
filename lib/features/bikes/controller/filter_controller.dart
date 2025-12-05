import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';

class FilterController extends GetxController {
  // Observable variables
  final Rx<RangeValues> priceRange = const RangeValues(0, 1000000).obs;
  final RxString selectedLocation = FilterStrings.allLocations.obs;
  final RxString selectedStatus = FilterStrings.all.obs;
  final RxDouble maxUsedYears = 20.0.obs;

  // Constants
  final List<String> locations = [
    FilterStrings.allLocations,
    FilterStrings.kathmandu,
    FilterStrings.pokhara,
    FilterStrings.lalitpur,
    FilterStrings.bhaktapur,
    FilterStrings.chitwan,
    FilterStrings.biratnagar,
    FilterStrings.other,
  ];

  final List<String> statusOptions = [
    FilterStrings.all,
    FilterStrings.available,
    FilterStrings.sold,
  ];

  // Methods
  void updatePriceRange(RangeValues values) {
    priceRange.value = values;
  }

  void updateLocation(String location) {
    selectedLocation.value = location;
  }

  void updateStatus(String status) {
    selectedStatus.value = status;
  }

  void updateMaxUsedYears(double years) {
    maxUsedYears.value = years;
  }

  void resetFilters() {
    priceRange.value = const RangeValues(0, 1000000);
    selectedLocation.value = FilterStrings.allLocations;
    selectedStatus.value = FilterStrings.all;
    maxUsedYears.value = 20.0;
  }

  List<CreatePostModel> applyFilters(List<CreatePostModel> allBikes) {
    return allBikes.where((bike) {
      // Price filter
      if (bike.price < priceRange.value.start ||
          bike.price > priceRange.value.end) {
        return false;
      }

      // Location filter
      if (selectedLocation.value != FilterStrings.allLocations &&
          !bike.location.toLowerCase().contains(
            selectedLocation.value.toLowerCase(),
          )) {
        return false;
      }

      // Status filter
      if (selectedStatus.value != FilterStrings.all &&
          bike.status != selectedStatus.value) {
        return false;
      }

      // Used years filter
      if (bike.usedDurationInYears > maxUsedYears.value) {
        return false;
      }

      return true;
    }).toList();
  }
}
