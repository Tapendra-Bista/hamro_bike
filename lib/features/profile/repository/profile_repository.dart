import 'package:hamro_bike/features/profile/model/profile_model.dart';
import '../../../services/base_repository.dart';

class ProfileRepository extends BaseRepository {


// get user profile
  Future<ProfileModel?> getUserProfile() async {
    try {
      final snapshot = await firestore.collection('users').doc(userId).get();
      if (snapshot.exists) {
        return ProfileModel.fromJson(snapshot.data()!);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

// log out
  Future<void> logOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // delete account
  Future<void> deleteAccount() async {
    try {
      // Delete user document from Firestore
      await firestore.collection('users').doc(userId).delete();
      // Delete user from Firebase Auth
      final user = auth.currentUser;
      if (user != null && user.uid == userId) {
        await user.delete();
      }
    } catch (e) {
      rethrow;
    }
  }
}
