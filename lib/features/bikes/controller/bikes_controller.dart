import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/features/bikes/repository/bikes_repository.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';
import 'package:hamro_bike/features/profile/model/profile_model.dart';
import 'package:logger/web.dart';

import '../../create_post/model/post_like_model.dart';

class BikesController extends GetxController {
  // Instance
  final BikesRepository _bikesRepository = .new();
  final Logger _logger = .new();
  final FirebaseAuth auth = FirebaseAuth.instance;

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

  @override
  void onClose() {
    // Clear cached data to prevent memory leaks
    _bikesList.clear();
    _posterProfile.clear();
    _posterProfileMap.clear();
    super.onClose();
  }

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
      final futures = uids.map((uid) => fetchPosterProfileIfNeeded(uid));
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
      Get.context?.showSnackBar(
        'Error While fetching bikes :$errorMessage',
        background: Colors.red,
      );
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
      Get.context?.showSnackBar(
        'Error adding like: $e',
        background: Colors.red,
      );
    }
  }

  // remove like
  Future<void> removeLike(String postId) async {
    try {
      await _bikesRepository.removeLike(postId);
    } catch (e) {
      _logger.e('Error removing like: $e');
      Get.context?.showSnackBar(
        'Error removing like: $e',
        background: Colors.red,
      );
    }
  }

  // getlike
  Stream<PostLikeModel?> streamLikes(String postId) {
    try {
      return _bikesRepository.streamLikes(postId);
    } catch (e) {
      _logger.e('Error streaming likes: $e');
      Get.context?.showSnackBar(
        'Error streaming likes: $e',
        background: Colors.red,
      );
      return const Stream.empty();
    }
  }

  // Add comment
  Future<void> addComment({
    required String postId,
    required String comment,
    required String userName,
    required String userProfile,
  }) async {
    try {
      await _bikesRepository.addComment(
        postId: postId,
        comment: comment,
        userName: userName,
        userProfile: userProfile,
      );
    } catch (e) {
      _logger.e('Error adding comment: $e');
      Get.context?.showSnackBar('Error adding comment', background: Colors.red);
    }
  }

  // Get comments
  Stream<List<Map<String, dynamic>>> getComments(String postId) {
    try {
      return _bikesRepository.getComments(postId);
    } catch (e) {
      _logger.e('Error getting comments: $e');
      return const Stream.empty();
    }
  }

  // Delete comment
  Future<void> deleteComment(String postId, String commentId) async {
    try {
      await _bikesRepository.deleteComment(postId, commentId);
    } catch (e) {
      _logger.e('Error deleting comment: $e');
      Get.context?.showSnackBar(
        'Error deleting comment',
        background: Colors.red,
      );
    }
  }

  // Add to favorites
  Future<void> addToFavorites(String postId) async {
    try {
      await _bikesRepository.addToFavorites(postId);
      Get.context?.showSnackBar('Added to favorites', background: Colors.green);
    } catch (e) {
      _logger.e('Error adding to favorites: $e');
      Get.context?.showSnackBar(
        'Error adding to favorites',
        background: Colors.red,
      );
    }
  }

  // Remove from favorites
  Future<void> removeFromFavorites(String postId) async {
    try {
      await _bikesRepository.removeFromFavorites(postId);
      Get.context?.showSnackBar(
        'Removed from favorites',
        background: Colors.orange,
      );
    } catch (e) {
      _logger.e('Error removing from favorites: $e');
      Get.context?.showSnackBar(
        'Error removing from favorites',
        background: Colors.red,
      );
    }
  }

  // Check if favorite
  Stream<bool> isFavorite(String postId) {
    return _bikesRepository.isFavorite(postId);
  }

  // Get favorites
  Stream<List<String>> getFavorites() {
    return _bikesRepository.getFavorites();
  }

  // Get favorite bikes
  Future<List<CreatePostModel>> getFavoriteBikes() async {
    try {
      return await _bikesRepository.getFavoriteBikes();
    } catch (e) {
      _logger.e('Error getting favorite bikes: $e');
      return [];
    }
  }

  // Report post
  Future<void> reportPost({
    required String postId,
    required String reason,
  }) async {
    try {
      final userId = auth.currentUser?.uid;
      if (userId == null) throw Exception('User not logged in');

      await _bikesRepository.reportPost(
        postId: postId,
        userId: userId,
        reason: reason,
      );
      Get.context!.showSnackBar('Post reported successfully');
    } catch (e) {
      _logger.e('Error reporting post: $e');
      Get.context!.showSnackBar('Failed to report post');
    }
  }

  // Block user
  Future<void> blockUser(String blockedUserId) async {
    try {
      final userId = auth.currentUser?.uid;
      if (userId == null) throw Exception('User not logged in');

      await _bikesRepository.blockUser(
        currentUserId: userId,
        blockedUserId: blockedUserId,
      );
      Get.context!.showSnackBar('User blocked successfully');
    } catch (e) {
      _logger.e('Error blocking user: $e');
      Get.context!.showSnackBar('Failed to block user');
    }
  }

  // Check if user is blocked
  Future<bool> isUserBlocked(String userId) async {
    try {
      final currentUserId = auth.currentUser?.uid;
      if (currentUserId == null) return false;

      return await _bikesRepository.isUserBlocked(
        currentUserId: currentUserId,
        userId: userId,
      );
    } catch (e) {
      _logger.e('Error checking if user is blocked: $e');
      return false;
    }
  }

  // Unblock user
  Future<void> unblockUser(String blockedUserId) async {
    try {
      final userId = auth.currentUser?.uid;
      if (userId == null) throw Exception('User not logged in');

      await _bikesRepository.unblockUser(
        currentUserId: userId,
        blockedUserId: blockedUserId,
      );
      Get.context!.showSnackBar('User unblocked successfully');
    } catch (e) {
      _logger.e('Error unblocking user: $e');
      Get.context!.showSnackBar('Failed to unblock user');
    }
  }
}
