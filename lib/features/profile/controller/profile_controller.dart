import 'package:flutter/material.dart';
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
  final ProfileRepository profileRepository = ProfileRepository();
  // Variables
  final Rxn<ProfileModel> _userProfile = Rxn<ProfileModel>();
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
      await profileRepository.logOut();

      // Clear local state early to avoid null access elsewhere
      userProfile = null;

      // Close any open dialog before showing snackbar
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      snackbar(
        ConstantStrings.logoutSuccess,
        ConstantColors.primaryButtonColor,
      );
      // Navigate to auth if not already handled by auth state stream
      if (Get.currentRoute != RoutesName.authentication) {
        Get.offAllNamed(RoutesName.authentication);
      }
    } catch (e) {
      Logger().e('Error during logout: $e');
      snackbar('Failed to log out: $e', Colors.red);
    } finally {
      isLoggingOut = false;
    }
  }

  Future<void> deleteAccount() async {
    try {
      isDeletingAccount = true;
      await profileRepository.deleteAccount();
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      snackbar(ConstantStrings.delete, ConstantColors.primaryButtonColor);
    } catch (e) {
      Logger().e('Error during account deletion: $e');
      snackbar('Failed to delete account: $e', Colors.red);
    }
  }
}
