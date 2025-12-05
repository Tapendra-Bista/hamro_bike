import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';
import 'package:hamro_bike/services/base_repository.dart';

class SearchRepository extends BaseRepository {
  // Get all bikes
  Future<List<CreatePostModel>> getAllBikes() async {
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

  // Search bikes by query
  Future<List<CreatePostModel>> searchBikes(String query) async {
    try {
      final QuerySnapshot querySnapshot = await firestore
          .collection('posts')
          .orderBy('postDate', descending: true)
          .get();

      final docs = querySnapshot.docs;
      if (docs.isEmpty) return [];

      final allBikes = docs
          .map(
            (doc) =>
                CreatePostModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();

      // Filter locally (Firestore doesn't support multiple field search efficiently)
      final searchQuery = query.toLowerCase();
      return allBikes.where((bike) {
        return bike.title.toLowerCase().contains(searchQuery) ||
            bike.vehicleName.toLowerCase().contains(searchQuery) ||
            bike.description.toLowerCase().contains(searchQuery) ||
            bike.location.toLowerCase().contains(searchQuery);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
