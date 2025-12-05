import 'package:get/get.dart';

import '../controller/bikes_controller.dart';

/// Binding for Bikes feature
class BikesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BikesController>(() => BikesController());
  }
}
