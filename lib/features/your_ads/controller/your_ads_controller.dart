import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/widgets/snackbar.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';
import 'package:hamro_bike/features/your_ads/repository/your_ads_repository.dart';
import 'package:logger/logger.dart';

class YourAdsController extends GetxController {
  // instance
  final YouAdsRepository _yourAdsRepository = .new();
  final Logger _logger = .new();

  // variables
  final RxBool _isShimmerEnable = false.obs;
  final RxBool _isdeleting = false.obs;
  final RxList<CreatePostModel> _yourAdsList = <CreatePostModel>[].obs;
  StreamSubscription? _adsSub;

  // getters
  bool get isShimmerEnable => _isShimmerEnable.value;
  bool get isDeleting => _isdeleting.value;
  List<CreatePostModel> get yourAdsList => _yourAdsList;

  // setter
  set isShimmerEnable(bool value) => _isShimmerEnable.value = value;
  set isDeleting(bool value) => _isdeleting.value = value;
  set yourAdsList(List<CreatePostModel> value) => _yourAdsList.value = value;

  // fetch your ads
  void fetchYourAds() {
    try {
      isShimmerEnable = true;
      _adsSub = _yourAdsRepository.getYourAds().listen((ads) {
        yourAdsList = ads;
      });
    } catch (e) {
      _logger.e('Error fetching your ads: $e');
      snackbar('Error fetching your ads: $e', Colors.red);
      rethrow;
    } finally {
      isShimmerEnable = false;
    }
  }

  // delete post
  Future<void> deletePost(String postId) async {
    try {
      isDeleting = true;
      await _yourAdsRepository.deletePost(postId);
      snackbar('Post deleted successfully', Colors.green);
    } catch (e) {
      _logger.e('Error deleting post: $e');
      snackbar('Error deleting post: $e', Colors.red);
    } finally {
      isDeleting = false;
    }
  }

  // make as sold
  Future<void> makeAsSold(String postId) async {
    try {
      await _yourAdsRepository.makeAsSold(postId);
      snackbar('Post marked as sold', Colors.green);
    } catch (e) {
      _logger.e('Error marking post as sold: $e');
      snackbar('Error marking post as sold: $e', Colors.red);
    }
  }

  // update post
  Future<void> updatePost(CreatePostModel model) async {
    try {
      await _yourAdsRepository.updatePost(model);
      snackbar('Post updated successfully', Colors.green);
    } catch (e) {
      _logger.e('Error updating post: $e');
      snackbar('Error updating post: $e', Colors.red);
    }
  }

  @override
  void onClose() {
    _adsSub?.cancel();
    super.onClose();
  }
}
