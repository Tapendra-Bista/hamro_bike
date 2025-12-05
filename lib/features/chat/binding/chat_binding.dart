import 'package:get/get.dart';

import '../controller/chat_controller.dart';

/// Binding for Chat feature
class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
