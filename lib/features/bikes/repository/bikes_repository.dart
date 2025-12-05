import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';

import '../../../services/base_repository.dart';
import '../../create_post/model/post_like_model.dart';
import '../../profile/model/profile_model.dart';

class BikesRepository extends BaseRepository {
  // fetches Bikes
  Future<List<CreatePostModel>> bikesData() async {
    try {
      final QuerySnapshot querySnapshot = await firestore
          .collection('posts')
          .orderBy('postDate', descending: true)
          .get();
      final docs = querySnapshot.docs;
      if (docs.isEmpty) return [];
      final bikes = docs
          .map(
            (doc) =>
                CreatePostModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
      return bikes;
    } catch (e) {
      rethrow;
    }
  }

  // poster Id
  Future<ProfileModel?> getPosterProfile(String uId) async {
    try {
      if (uId.isEmpty) {
        throw Exception('Invalid user ID');
      }
      final DocumentSnapshot doc = await firestore
          .collection('users')
          .doc(uId)
          .get();
      if (!doc.exists) return null;
      final data = doc.data();
      if (data == null) return null;
      return ProfileModel.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  // like using stream
  //adding like
  Future<void> addLike(String postId) async {
    final likeDocRef = firestore
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc('main');

    await likeDocRef.set({
      'likeId': FieldValue.arrayUnion([userId]),
    }, SetOptions(merge: true));
  }

  //removing like
  Future<void> removeLike(String postId) async {
    final likeDocRef = firestore
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc('main');

    await likeDocRef.update({
      'likeId': FieldValue.arrayRemove([userId]),
    });

    final snap = await likeDocRef.get();
    final list = (snap.data()?['likeId'] as List?) ?? [];

    if (list.isEmpty) {
      await likeDocRef.delete();
    }
  }

  //fetching likes
  Stream<PostLikeModel?> streamLikes(String postId) {
    final likeDocRef = firestore
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc('main');

    return likeDocRef.snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return PostLikeModel.fromJson(doc.data()!);
    });
  }

  // Add comment
  Future<void> addComment({
    required String postId,
    required String comment,
    required String userName,
    required String userProfile,
  }) async {
    try {
      final commentId = firestore.collection('posts').doc().id;
      final timestamp = DateTime.now();

      await firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .set({
            'commentId': commentId,
            'postId': postId,
            'userId': userId,
            'userName': userName,
            'userProfile': userProfile,
            'comment': comment,
            'timestamp': Timestamp.fromDate(timestamp),
          });
    } catch (e) {
      rethrow;
    }
  }

  // Get comments stream
  Stream<List<Map<String, dynamic>>> getComments(String postId) {
    try {
      return firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) => doc.data()).toList();
          });
    } catch (e) {
      rethrow;
    }
  }

  // Delete comment
  Future<void> deleteComment(String postId, String commentId) async {
    try {
      await firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  // Add to favorites
  Future<void> addToFavorites(String postId) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(postId)
          .set({
            'postId': postId,
            'timestamp': Timestamp.fromDate(DateTime.now()),
          });
    } catch (e) {
      rethrow;
    }
  }

  // Remove from favorites
  Future<void> removeFromFavorites(String postId) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(postId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  // Check if post is favorite
  Stream<bool> isFavorite(String postId) {
    try {
      return firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(postId)
          .snapshots()
          .map((doc) => doc.exists);
    } catch (e) {
      return Stream.value(false);
    }
  }

  // Get all favorites
  Stream<List<String>> getFavorites() {
    try {
      return firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs
                .map((doc) => doc.data()['postId'] as String)
                .toList();
          });
    } catch (e) {
      return Stream.value([]);
    }
  }

  // Get favorite bikes
  Future<List<CreatePostModel>> getFavoriteBikes() async {
    try {
      final favSnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .orderBy('timestamp', descending: true)
          .get();

      final postIds = favSnapshot.docs
          .map((doc) => doc.data()['postId'] as String)
          .toList();

      if (postIds.isEmpty) return [];

      final bikes = <CreatePostModel>[];
      for (final postId in postIds) {
        final doc = await firestore.collection('posts').doc(postId).get();
        if (doc.exists) {
          bikes.add(CreatePostModel.fromJson(doc.data()!));
        }
      }
      return bikes;
    } catch (e) {
      rethrow;
    }
  }

  // Report post
  Future<void> reportPost({
    required String postId,
    required String userId,
    required String reason,
  }) async {
    try {
      final reportId = firestore.collection('reports').doc().id;
      await firestore.collection('reports').doc(reportId).set({
        'reportId': reportId,
        'postId': postId,
        'reportedBy': userId,
        'reason': reason,
        'timestamp': Timestamp.now(),
        'status': 'pending',
      });
    } catch (e) {
      rethrow;
    }
  }

  // Block user
  Future<void> blockUser({
    required String currentUserId,
    required String blockedUserId,
  }) async {
    try {
      await firestore
          .collection('users')
          .doc(currentUserId)
          .collection('blockedUsers')
          .doc(blockedUserId)
          .set({'blockedUserId': blockedUserId, 'timestamp': Timestamp.now()});
    } catch (e) {
      rethrow;
    }
  }

  // Check if user is blocked
  Future<bool> isUserBlocked({
    required String currentUserId,
    required String userId,
  }) async {
    try {
      final doc = await firestore
          .collection('users')
          .doc(currentUserId)
          .collection('blockedUsers')
          .doc(userId)
          .get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  // Unblock user
  Future<void> unblockUser({
    required String currentUserId,
    required String blockedUserId,
  }) async {
    try {
      await firestore
          .collection('users')
          .doc(currentUserId)
          .collection('blockedUsers')
          .doc(blockedUserId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
