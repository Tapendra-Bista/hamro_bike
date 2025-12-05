import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/widgets/snackbar.dart';
import 'package:logger/logger.dart';

import '../../../common/constant/constant_strings.dart';
import '../../../routes/routes_name.dart';
import '../repository/authentication_repository.dart';

// Controller for Authentication feature
class AuthenticationController extends GetxController {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
  // obs variables
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  // setter
  set isLoading(bool value) => _isLoading.value = value;
  set errorMessage(String value) => _errorMessage.value = value;

  // getter
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  String? get currentUserId => authenticationRepository.auth.currentUser?.uid;

  Future<void> continueWithGoogle() async {
    if (isLoading) return; // prevent re-entrancy
    try {
      isLoading = true;
      errorMessage = '';

      // Show loading dialog - use Future.microtask to ensure overlay is ready
      await Future.microtask(() {
        if (Get.context != null && !Get.isDialogOpen!) {
          Get.dialog(
            WillPopScope(
              onWillPop: () async => false,
              child: const Center(
                child: CircularProgressIndicator(
                  color: ConstantColors.primaryButtonColor,
                ),
              ),
            ),
            barrierDismissible: false,
          );
        }
      });

      // Call your repository method here
      final user = await authenticationRepository.loginWithGoogle();
      if (user == null) {
        // Sign-in cancelled or failed without user
        errorMessage = 'Google sign-in was cancelled';
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        return;
      }

      final isAvailable = await authenticationRepository.isUserAvailable(
        user.uid,
      );

      if (isAvailable) {
        Logger().i('Login successful for existing user: ${user.uid}');
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        snackbar(
          ConstantStrings.loginSuccess,
          ConstantColors.primaryButtonColor,
        );
        // User exists, proceed accordingly

        Get.offAllNamed(RoutesName.dashboard);
        // e.g., navigation to dashboard
        return;
      }

      // User does not exist, create initial documents
      final userData = <String, dynamic>{
        'uid': user.uid,
        'email': user.email ?? '',
        'name': user.displayName ?? '',
        'profile': user.photoURL ?? '',
        'createdAt': DateTime.now(),
        // Add other user fields as necessary
      };

      // Keep using Future.wait to avoid additional imports/transactions here
      await authenticationRepository.firestore
          .collection('users')
          .doc(user.uid)
          .set(userData);
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      snackbar(
        ConstantStrings.signupSuccess,
        ConstantColors.primaryButtonColor,
      );
      Logger().i('New user created with UID: ${user.uid}');
      Get.offAllNamed(RoutesName.dashboard);
      // Close the dialog
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message ?? 'Authentication failed';
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      snackbar(errorMessage, Colors.red);
    } on FirebaseException catch (e) {
      // Handles Firestore/Storage exceptions
      errorMessage = e.message ?? 'A Firebase error occurred';
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      snackbar(errorMessage, Colors.red);
    } catch (e) {
      errorMessage = e.toString();
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      snackbar('Unexpected error in continueWithGoogle: $e', Colors.red);
      Logger().e('Unexpected error in continueWithGoogle: $e');
    } finally {
      isLoading = false;
    }
  }
}
