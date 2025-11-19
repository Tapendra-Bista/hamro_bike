import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/widgets/snackbar.dart';
import 'package:hamro_bike/features/bikes/repository/bikes_repository.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';
import 'package:hamro_bike/features/profile/model/profile_model.dart';
import 'package:logger/web.dart';

import '../../create_post/model/post_like_model.dart';

class BikesController extends GetxController {
  // Instance
  final BikesRepository _bikesRepository = .new();
  final Logger _logger = .new();

  // varibles
  final RxList<CreatePostModel> _bikesList = <CreatePostModel>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxList<ProfileModel> _posterProfile = <ProfileModel>[].obs;
  final RxMap<String, ProfileModel> _posterProfileMap =
      <String, ProfileModel>{}.obs;
  // setter
  set isLoading(bool value) => _isLoading.value = value;
  set errorMessage(String value) => _errorMessage.value = value;
  set bikesList(List<CreatePostModel> value) => _bikesList.value = value;
  set posterProfile(List<ProfileModel> value) => _posterProfile.value = value;
  set posterProfileMap(Map<String, ProfileModel> value) =>
      _posterProfileMap.value = value;
      

  // getter
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  List<CreatePostModel> get bikesList => _bikesList.toList();
  List<ProfileModel> get posterProfile => _posterProfile.toList();
Map<String, ProfileModel> get posterProfileMap => _posterProfileMap;


  /// Fetch poster profile if not already cached. Returns the profile or null.
  Future<ProfileModel?> fetchPosterProfileIfNeeded(String uId) async {
    try {
      if (uId.isEmpty) return null;
      if (posterProfileMap.containsKey(uId)) return posterProfileMap[uId];
      final profile = await _bikesRepository.getPosterProfile(uId);
      if (profile != null) {
        posterProfileMap[uId] = profile;
      }
      return profile;
    } catch (e) {
      Logger().e('Error fetching poster profile for $uId: $e');
      return null;
    }
  }

  /// Convenience: fetch profiles for all currently loaded bikes (deduplicated)
  Future<void> fetchProfilesForBikes() async {
    try {
      final uids = bikesList
          .map((b) => b.uId)
          .where((u) => u.isNotEmpty)
          .toSet();
      final futures = uids.map((uid) =>  fetchPosterProfileIfNeeded(uid));
      await Future.wait(futures);
    } catch (e) {
      Logger().e('Error fetching profiles for bikes: $e');
    }
  }

  // fetch bikes data
  Future<void> fetchData() async {
    try {
      isLoading = true;
      final bikes = await _bikesRepository.bikesData();
      bikesList = bikes;
      await fetchProfilesForBikes();
      Logger().d('Bikes fetched successfully: ${bikesList.length} items');
    } catch (e) {
      errorMessage = e.toString();
      Logger().d('Error While fetching bikes :$errorMessage');
      snackbar('Error While fetching bikes :$errorMessage', Colors.red);
    } finally {
      isLoading = false;
    }
  }

    // addlike 
  Future<void> addLike(String postId) async {
    try {
      await _bikesRepository.addLike(postId);
    } catch (e) {
      _logger.e('Error adding like: $e');
      snackbar('Error adding like: $e', Colors.red);
    }




  }

      // remove like
  Future<void> removeLike(String postId) async {
    try {       
      await _bikesRepository.removeLike(postId);
    } catch (e) {
      _logger.e('Error removing like: $e');
      snackbar('Error removing like: $e', Colors.red);
    }   
  }

  // getlike
  Stream<PostLikeModel?> streamLikes(String postId) {
    try {
      return _bikesRepository.streamLikes(postId);
    } catch (e) {
      _logger.e('Error streaming likes: $e');
      snackbar('Error streaming likes: $e', Colors.red);
      return const Stream.empty();
    }
  }
}
