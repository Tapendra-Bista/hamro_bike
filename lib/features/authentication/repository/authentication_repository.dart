import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../services/base_repository.dart';

// Repository for Authentication feature
class AuthenticationRepository extends BaseRepository {
  // login with google
  Future<User?> loginWithGoogle() async {
    try {
      // Step 1: Initialize the singleton once
      await GoogleSignIn.instance.initialize();

      // Step 2: Authenticate the user
      final googleUser = await GoogleSignIn.instance.authenticate(
        // Optional: request additional scopes right here
        // scopeHint: ['email', 'profile'],
      );

      // Step 3: Get GoogleAuth tokens
      final googleAuth = googleUser.authentication;

      // Step 4: Build Firebase credential
      final credential = GoogleAuthProvider.credential(
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
