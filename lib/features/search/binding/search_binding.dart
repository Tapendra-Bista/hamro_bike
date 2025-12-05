import 'package:get/get.dart';

import '../controller/search_controller.dart';

/// Binding for Search feature
class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
