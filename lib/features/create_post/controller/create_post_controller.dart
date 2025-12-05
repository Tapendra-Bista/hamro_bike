import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/widgets/snackbar.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';
import 'package:hamro_bike/features/create_post/repository/create_post_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class CreatePostController extends GetxController {
  // Instance
  final CreatePostRepository createPostRepository = CreatePostRepository();
  final ImagePicker _imagePicker = ImagePicker();
  final Logger _logger = Logger();
  final Uuid _uuid = const Uuid();

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
  final RxBool _isEditMode = false.obs;
  final Rxn<String> _editPostId = Rxn<String>();

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
  bool get isEditMode => _isEditMode.value;
  String? get editPostId => _editPostId.value;

  // Additional setters
  set isEditMode(bool value) => _isEditMode.value = value;
  set editPostId(String? value) => _editPostId.value = value;

  @override
  void onClose() {
    // Clear image data to prevent memory leaks
    _imageUrls.clear();
    _tempImagePaths.clear();
    resetForm();
    super.onClose();
  }

  /// Load post data for editing
  void loadPostForEdit(CreatePostModel post) {
    isEditMode = true;
    editPostId = post.postId;
    title = post.title;
    vehicleName = post.vehicleName;
    description = post.description;
    price = post.price;
    location = post.location;
    imageUrls = List<String>.from(post.imageUrls); // Create mutable copy
    tempImagePaths = List<String>.from(
      post.imageUrls,
    ); // Create mutable copy for editing
    usedDurationInYears = post.usedDurationInYears;
  }

  /// Reset form
  void resetForm() {
    isEditMode = false;
    editPostId = null;
    title = '';
    vehicleName = '';
    description = '';
    price = 0.0;
    location = '';
    imageUrls = [];
    tempImagePaths = [];
    usedDurationInYears = 0.0;
    currentStep = 0;
  }

  /// ✅ Update Post Function
  Future<bool> updatePost() async {
    try {
      isLoading = true;

      // Check if new images were picked (local file paths)
      final hasNewImages = tempImagePaths.any(
        (path) => !path.startsWith('http://') && !path.startsWith('https://'),
      );

      List<String> finalImageUrls;

      if (hasNewImages) {
        // Upload new images to Cloudinary
        await uploadImages();
        finalImageUrls = imageUrls;
      } else {
        // Keep existing URLs (no new images picked)
        finalImageUrls = tempImagePaths;
      }

      // Prepare updated post data model
      final updatedPostModel = CreatePostModel(
        postId: editPostId!,
        uId: FirebaseAuth.instance.currentUser!.uid,
        title: title,
        vehicleName: vehicleName,
        description: description,
        price: price,
        location: location,
        imageUrls: finalImageUrls,
        postDate: DateTime.now(),
        usedDurationInYears: usedDurationInYears,
      );

      // Update post in Firestore
      await createPostRepository.updatePost(updatedPostModel);

      isLoading = false;
      resetForm();
      return true;
    } catch (e, s) {
      isLoading = false;
      _logger.e('Failed to update post: $e', error: e, stackTrace: s);
      snackbar('Failed to update post: $e', Colors.red);
      return false;
    }
  }

  /// ✅ Create Post Function
  Future<bool> postData() async {
    try {
      // Start loading immediately (button onPressed context, safe outside build phase)
      isLoading = true;
      // Ensure user is authenticated
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        isLoading = false;
        snackbar('Please log in to create a post.', Colors.red);
        return false;
      }

      // Upload images first
      await uploadImages();

      // Prepare post data model
      final createPostModel = CreatePostModel(
        postId: _uuid.v4(),
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

      // Success: clear loading and let UI decide navigation & snackbar
      isLoading = false;
      // Close create post screen
      return true;
    } catch (e, s) {
      isLoading = false;
      _logger.e('Failed to create post: $e', error: e, stackTrace: s);
      snackbar('Failed to create post: $e', Colors.red);
      return false;
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
      tempImagePaths = selected;
    } catch (e) {
      _logger.e('Error picking images: $e');
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

        _logger.d('Uploaded image URL: $imageUrl');
      }

      imageUrls = uploadedUrls;
      tempImagePaths = [];
    } catch (e) {
      _logger.e('Error uploading images: $e');
      snackbar('Error uploading images: $e', Colors.red);
    }
  }
}
