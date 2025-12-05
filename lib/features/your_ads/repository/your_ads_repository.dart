import 'package:hamro_bike/services/base_repository.dart';

import '../../create_post/model/create_post_model.dart';

class YouAdsRepository extends BaseRepository {
  // fecth bikes using  poster uid
  Stream<List<CreatePostModel>> getYourAds() {
    try {
      final snapShot = firestore
          .collection('posts')
          .where('uId', isEqualTo: userId);

      return snapShot.snapshots().map((doc) {
        if (doc.docs.isEmpty) return [];
        return doc.docs.map((doc) {
          return CreatePostModel.fromJson(doc.data());
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  // delete post using post id
  Future<void> deletePost(String postId) async {
    try {
      await firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      rethrow;
    }
  }

  // make as sold using post id
  Future<void> makeAsSold(String postId) async {
    try {
      final postRef = firestore.collection('posts').doc(postId);
      await postRef.update({'status': 'sold'});
    } catch (e) {
      rethrow;
    }
  }

  // update post
  Future<void> updatePost(CreatePostModel model) async {
    try {
      await firestore
          .collection('posts')
          .doc(model.postId)
          .update(model.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
