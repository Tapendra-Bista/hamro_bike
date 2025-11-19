import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';

import '../../../services/base_repository.dart';

class CreatePostRepository extends BaseRepository {
  // post
  Future<void> postData(CreatePostModel model) async {
    try {
      await firestore.collection('posts').doc(model.postId).set(model.toMap());

    } catch (e) {
      rethrow;
    }
  }

  // Upload a single image file to Cloudinary and return the secure URL
  Future<String> uploadImageToCloudinary(String filePath) async {
    try {
      final cloudName = dotenv.get('cloudName', fallback: '');
      final uploadPreset = dotenv.get('uploadPreset', fallback: '');
      if (cloudName.isEmpty || uploadPreset.isEmpty) {
        throw Exception(
          'Missing Cloudinary configuration. Ensure cloudName and uploadPreset are set in .env',
        );
      }
      final cloudinary = CloudinaryPublic(
        cloudName,
        uploadPreset,
        cache: false,
      );
      final response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          filePath,
          resourceType: .Image,
          folder: 'hamro_bike_posts',
        ),
      );
      return response.secureUrl;
    } catch (e) {
      rethrow;
    }
  }
}
