import 'package:get/get.dart';
import '../controllers/authentication_controllers.dart';

// Binding for Authentication feature
class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationController());
  }
  
}