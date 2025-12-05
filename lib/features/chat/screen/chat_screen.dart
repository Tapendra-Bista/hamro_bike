import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/utils/timestamps_convertor.dart';
import 'package:hamro_bike/features/chat/controller/chat_controller.dart';
import 'package:hamro_bike/features/chat/screen/chat_detail_screen.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: ConstantColors.primaryButtonColor,
            ),
          );
        }

        if (controller.chatsList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.forum_outlined,
                  size: 80.sp,
                  color: ConstantColors.secondaryTextColor,
                ),
                SizedBox(height: 16.h),
                Text(
                  'No chats yet',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: ConstantColors.secondaryTextColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Start chatting with sellers',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: ConstantColors.secondaryTextColor,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          itemCount: controller.chatsList.length,
          separatorBuilder: (context, index) =>
              Divider(height: 1.h, color: ConstantColors.dividersColor),
          itemBuilder: (context, index) {
            final chat = controller.chatsList[index];

            return Dismissible(
              key: Key(chat.chatId),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20.w),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                return await Get.dialog<bool>(
                      AlertDialog(
                        backgroundColor: ConstantColors.containerColor,
                        title: const Text('Delete Chat'),
                        content: const Text(
                          'Are you sure you want to delete this chat?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(result: false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Get.back(result: true),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    ) ??
                    false;
              },
              onDismissed: (direction) {
                controller.deleteChat(chat.chatId);
              },
              child: RepaintBoundary(
                child: ListTile(
                  onTap: () {
                    Get.to(() => ChatDetailScreen(chat: chat));
                  },
                  leading: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: chat.postImageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[800],
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2.w,
                            color: ConstantColors.primaryButtonColor,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[800],
                        child: Icon(Icons.person, size: 25.sp),
                      ),
                    ),
                  ),
                  title: Text(
                    chat.postTitle,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ConstantColors.secondaryButtonColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    chat.lastMessage.isEmpty
                        ? 'No messages yet'
                        : chat.lastMessage,
                    style: context.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        TimestampConverter.formatTimeAgo(chat.lastMessageTime),
                        style: context.textTheme.bodySmall!.copyWith(
                          fontSize: 10.sp,
                        ),
                      ),
                      if (chat.unreadCount > 0) ...[
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: ConstantColors.primaryButtonColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            chat.unreadCount > 99
                                ? '99+'
                                : chat.unreadCount.toString(),
                            style: context.textTheme.bodySmall!.copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
