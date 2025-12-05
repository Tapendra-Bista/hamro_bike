import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_strings.dart';
import 'package:hamro_bike/common/extensions/extensions_buildcontext.dart';
import 'package:hamro_bike/features/chat/controller/chat_controller.dart';
import 'package:hamro_bike/features/chat/model/chat_model.dart';
import 'package:hamro_bike/features/chat/screen/chat_detail_screen.dart';
import 'package:hamro_bike/features/create_post/model/create_post_model.dart';

class BikeChat extends StatelessWidget {
  const BikeChat({super.key, required this.bike});

  final CreatePostModel bike;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(
          ConstantStrings.details,
          style: context.textTheme.bodyLarge!.copyWith(
            fontSize: 20.sp,
            fontWeight: .bold,
          ),
        ),

        Row(
          spacing: 5.w,
          children: [
            Text(
              '${ConstantStrings.chat} : ',
              style: context.textTheme.bodySmall,
            ),
            IconButton(
              style: context.iconButtonTheme.style!.copyWith(
                fixedSize: WidgetStatePropertyAll(Size(60, 60)),
              ),
              onPressed: _startChat,
              icon: Icon(CupertinoIcons.chat_bubble, size: 35.sp),
            ),
          ],
        ),
      ],
    ).paddingSymmetric(horizontal: 10.w);
  }

  Future<void> _startChat() async {
    try {
      final chatController = Get.find<ChatController>();
      final currentUserId = chatController.currentUserId;

      // Check if trying to chat with self
      if (currentUserId == bike.uId) {
        Get.snackbar(
          'Error',
          'You cannot chat with yourself',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Show loading indicator
      if (Get.context != null) {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );
      }

      // Create or get existing chat
      final chatId = await chatController.createOrGetChat(
        receiverId: bike.uId,
        postId: bike.postId,
        postTitle: bike.title,
        postImageUrl: bike.imageUrls.isNotEmpty ? bike.imageUrls.first : '',
      );

      // Close loading dialog
      Get.back();

      if (chatId != null) {
        // Navigate to chat detail screen
        final chat = ChatModel(
          chatId: chatId,
          senderId: currentUserId,
          receiverId: bike.uId,
          postId: bike.postId,
          postTitle: bike.title,
          postImageUrl: bike.imageUrls.isNotEmpty ? bike.imageUrls.first : '',
          lastMessage: '',
          lastMessageTime: DateTime.now(),
          unreadCount: 0,
        );

        Get.to(() => ChatDetailScreen(chat: chat));
      }
    } catch (e) {
      // Close loading dialog if still open
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.snackbar(
        'Error',
        'Failed to start chat: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
