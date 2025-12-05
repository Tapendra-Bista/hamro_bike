import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:hamro_bike/routes/routes_name.dart';
import 'package:logger/logger.dart';

import '../../../common/widgets/snackbar.dart';
import '../model/profile_model.dart';
import '../repository/profile_repository.dart';

class ProfileController extends GetxController {
  // instance of ProfileRepository
  final ProfileRepository profileRepository = .new();
  // Variables
  final Rxn<ProfileModel> _userProfile = .new();
  final RxBool _shrimmerLoading = false.obs;
  final RxString _errorString = ''.obs;
  final RxBool _isDeleting = false.obs;
  final RxBool _isLoggingOut = false.obs;

  // getter
  ProfileModel? get userProfile => _userProfile.value;
  bool get isDeletingAccount => _isDeleting.value;
  bool get shrimmerLoading => _shrimmerLoading.value;
  String get errorString => _errorString.value;
  bool get isLoggingOut => _isLoggingOut.value;

  // setter
  set userProfile(ProfileModel? profile) => _userProfile.value = profile;
  set shrimmerLoading(bool value) => _shrimmerLoading.value = value;
  set errorString(String value) => _errorString.value = value;
  set isDeletingAccount(bool value) => _isDeleting.value = value;
  set isLoggingOut(bool value) => _isLoggingOut.value = value;

  // fetch user profile
  Future<void> getProfile() async {
    try {
      shrimmerLoading = true;
      errorString = '';
      final data = await profileRepository.getUserProfile();
      if (data != null) {
        userProfile = data;
      }
    } catch (e) {
      errorString = e.toString();
      Logger().e('Error fetching user profile: $e');

      snackbar('Failed to load profile: $e', Colors.red);
    } finally {
      shrimmerLoading = false;
    }
  }

  // log out user
  Future<void> logOut() async {
    try {
      if (isLoggingOut) return; // prevent re-entrancy
      isLoggingOut = true;

      // Show loading dialog only if Get context is available
      if (Get.context != null) {
        Get.dialog(
          PopScope(
            canPop: false,
            child: Center(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16.h),
                      Text(ConstantStrings.logoutInProgress),
                    ],
                  ),
                ),
              ),
            ),
          ),
          barrierDismissible: false,
        );
      }

      await profileRepository.logOut();

      // Clear local state early to avoid null access elsewhere
      userProfile = null;

      // Close loading dialog
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      // Navigate to auth if not already handled by auth state stream
      if (Get.currentRoute != RoutesName.authentication) {
        Get.offAllNamed(RoutesName.authentication);
      }
    } catch (e) {
      Logger().e('Error during logout: $e');
      // Close loading dialog on error
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    } finally {
      isLoggingOut = false;
    }
  }

  Future<void> deleteAccount() async {
    // Show confirmation dialog first
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: ConstantColors.containerColor,
        title: Text('Delete Account', style: TextStyle(color: Colors.white)),
        content: Text(
          'Are you sure you want to permanently delete your account? This action cannot be undone.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    // If user didn't confirm, return
    if (confirmed != true) return;

    try {
      isDeletingAccount = true;

      // Show loading dialog only if Get context is available
      if (Get.context != null) {
        Get.dialog(
          PopScope(
            canPop: false,
            child: Center(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16.h),
                      Text(ConstantStrings.deletingAccount),
                    ],
                  ),
                ),
              ),
            ),
          ),
          barrierDismissible: false,
        );
      }

      await profileRepository.deleteAccount();

      // Clear local state
      userProfile = null;

      // Close loading dialog
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      // Show success message
      snackbar(ConstantStrings.delete, ConstantColors.primaryButtonColor);

      // Navigate to authentication screen
      await Future.delayed(Duration(seconds: 1));
      Get.offAllNamed(RoutesName.authentication);
    } catch (e) {
      Logger().e('Error during account deletion: $e');

      // Close loading dialog on error
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      snackbar('Failed to delete account: $e', Colors.red);
    } finally {
      isDeletingAccount = false;
    }
  }
}
