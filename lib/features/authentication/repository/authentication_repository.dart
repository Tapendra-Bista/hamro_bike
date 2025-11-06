import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../services/base_repository.dart';

// Repository for Authentication feature
class AuthenticationRepository extends BaseRepository {
  // login with google
  Future<User?> loginWithGoogle() async {
    try {
      // Sign in with Google using standard API
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null; // user cancelled

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  // checking if user available or not
  Future<bool> isUserAvailable(String uid) async {
    try {
      final snapshot = await firestore.collection('users').doc(uid).get();

      return snapshot.exists;
    } catch (e) {
      return false;
    }
  }
}
