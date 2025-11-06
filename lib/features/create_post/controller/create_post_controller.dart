import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/widgets/snackbar.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';
import 'package:hamro_bike/features/create_post/repository/create_post_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../common/constant/constant_colors.dart';
import '../../../common/constant/constant_strings.dart';

class CreatePostController extends GetxController {
  // Instance
  final CreatePostRepository createPostRepository = CreatePostRepository();
  final ImagePicker _imagePicker = ImagePicker();

  // Reactive variables
  final RxBool _isLoading = false.obs;
  final RxString _title = ''.obs;
  final RxString _vehicleName = ''.obs;
  final RxString _description = ''.obs;
  final RxDouble _price = 0.0.obs;
  final RxString _location = ''.obs;
  final RxList<String> _imageUrls = <String>[].obs;
  final RxList<String> _tempImagePaths = <String>[].obs;
  final RxDouble _usedDurationInYears = 0.0.obs;
  final RxInt _currentStep = 0.obs;

  // Setters
  set isLoading(bool value) => _isLoading.value = value;
  set title(String value) => _title.value = value;
  set vehicleName(String value) => _vehicleName.value = value;
  set description(String value) => _description.value = value;
  set price(double value) => _price.value = value;
  set location(String value) => _location.value = value;
  set imageUrls(List<String> value) => _imageUrls.value = value;
  set usedDurationInYears(double value) => _usedDurationInYears.value = value;
  set currentStep(int value) => _currentStep.value = value;
  set tempImagePaths(List<String> value) => _tempImagePaths.value = value;

  // Getters
  bool get isLoading => _isLoading.value;
  String get title => _title.value;
  String get vehicleName => _vehicleName.value;
  String get description => _description.value;
  double get price => _price.value;
  String get location => _location.value;
  List<String> get imageUrls => _imageUrls;
  double get usedDurationInYears => _usedDurationInYears.value;
  int get currentStep => _currentStep.value;
  List<String> get tempImagePaths => _tempImagePaths;

  /// ✅ Create Post Function
  Future<void> postData() async {
    try {
      // Ensure user is authenticated
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        snackbar('Please log in to create a post.', Colors.red);
        return;
      }

      // Start loading
      isLoading = true;

      // Upload images first
      await uploadImages();

      // Prepare post data model
      final createPostModel = CreatePostModel(
        uId: uid,
        title: title,
        vehicleName: vehicleName,
        description: description,
        price: price,
        location: location,
        imageUrls: imageUrls,
        postDate: DateTime.now(),
        usedDurationInYears: usedDurationInYears,
      );

      // Store post in Firestore
      await createPostRepository.postData(createPostModel);

      // Stop loader
      isLoading = false;
      Logger().f('Post created successfully.');
      // // Safe navigation after a short delay
      // Future.delayed(const Duration(milliseconds: 100), () {
      //   Get.toNamed(RoutesName.dashboard);
      //   // Or: Get.offAllNamed(RoutesName.dashboard); if you want to clear stack
      // });
      //       // Show success snackbar
      snackbar(
        ConstantStrings.postCreateSuccess,
        ConstantColors.primaryButtonColor,
      );
    } catch (e, s) {
      isLoading = false;
      Logger().e('Failed to create post: $e', error: e, stackTrace: s);
      snackbar('Failed to create post: $e', Colors.red);
    }
  }

  /// ✅ Pick multiple images from gallery
  Future<void> pickImages() async {
    try {
      final List<XFile> paths = await _imagePicker.pickMultiImage(
        maxHeight: 1920,
        maxWidth: 1920,
        limit: 6,
      );

      final selected = paths.map((e) => e.path).toList();
      // Use _postFrame to safely update reactive list during UI frame
      tempImagePaths = selected;
    } catch (e) {
      Logger().e('Error picking images: $e');
      snackbar('Error picking images: $e', Colors.red);
    }
  }

  /// ✅ Upload images to Cloudinary
  Future<void> uploadImages() async {
    try {
      if (tempImagePaths.isEmpty) {
        snackbar('Please select images first.', Colors.red);
        return;
      }

      final List<String> uploadedUrls = [];

      for (final path in tempImagePaths) {
        final imageUrl = await createPostRepository.uploadImageToCloudinary(
          path,
        );
        uploadedUrls.add(imageUrl);

        // Optional: Clean up temporary file
        final lower = path.toLowerCase();
        final looksTemp = lower.contains('cache') || lower.contains('tmp');
        if (looksTemp) {
          try {
            final file = File(path);
            if (await file.exists()) {
              await file.delete();
            }
          } catch (_) {
            // Ignore cleanup errors
          }
        }
      }

      // Update state safely (after uploads complete)
      imageUrls = uploadedUrls;
      tempImagePaths = [];
    } catch (e) {
      Logger().e('Error uploading images: $e');
      snackbar('Error uploading images: $e', Colors.red);
    }
  }
}
