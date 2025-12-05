import 'package:get/get.dart';

import '../controller/profile_controller.dart';

/// Binding for Profile feature
class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
