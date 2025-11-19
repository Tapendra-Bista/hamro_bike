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
          .collection('posts').orderBy('postDate', descending: true)
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

}
