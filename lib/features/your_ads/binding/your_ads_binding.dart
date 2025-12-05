import 'package:get/get.dart';
import '../controller/your_ads_controller.dart';
// binding for your ads feature
class YourAdsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YourAdsController>(() => .new());
  }
}
