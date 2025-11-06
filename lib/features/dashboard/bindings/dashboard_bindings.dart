import 'package:get/get.dart';

import '../controller/dashboard_controller.dart';

// Binding for Dashboard feature
class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Use fenix so it auto re-creates after being removed during nav resets
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
  }
}
