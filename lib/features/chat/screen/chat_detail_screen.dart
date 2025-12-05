import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/constant/constant_colors.dart';
import 'package:hamro_bike/common/utils/timestamps_convertor.dart';
import 'package:hamro_bike/common/widgets/comman_back_button.dart';
import 'package:hamro_bike/features/chat/controller/chat_controller.dart';
import 'package:hamro_bike/features/chat/model/chat_model.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key, required this.chat});

  final ChatModel chat;

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late ChatController _chatController;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _previousMessageCount = 0;

  @override
  void initState() {
    super.initState();
    _chatController = Get.find<ChatController>();
    _chatController.fetchChatMessages(widget.chat.chatId);
    _chatController.markMessagesAsRead(widget.chat.chatId);

    // Auto-scroll to bottom when keyboard appears or new messages arrive
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final otherUserId = _chatController.getOtherUserId(widget.chat);
    await _chatController.sendMessage(
      chatId: widget.chat.chatId,
      receiverId: otherUserId,
      message: _messageController.text.trim(),
    );
    _messageController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CommanBackButton(),
        title: Row(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.chat.postImageUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[800],
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    color: ConstantColors.primaryButtonColor,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[800],
                  child: const Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.postTitle,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: Obx(() {
              // Auto-scroll when new messages arrive
              if (_chatController.messages.length != _previousMessageCount) {
                _previousMessageCount = _chatController.messages.length;
                _scrollToBottom();
              }

              if (_chatController.messages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 64.sp,
                        color: ConstantColors.secondaryTextColor,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No messages yet',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: ConstantColors.secondaryTextColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Start the conversation!',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodySmall!.copyWith(
                          color: ConstantColors.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                controller: _scrollController,
                reverse: true,
                padding: EdgeInsets.all(16.w),
                itemCount: _chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = _chatController.messages[index];
                  final isMe =
                      message.senderId == _chatController.currentUserId;
                  final showTime =
                      index == 0 ||
                      _chatController.messages[index - 1].timestamp
                              .difference(message.timestamp)
                              .inMinutes
                              .abs() >
                          5;

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (showTime)
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Center(
                              child: Text(
                                TimestampConverter.formatTimeAgo(
                                  message.timestamp,
                                ),
                                style: context.textTheme.bodySmall!.copyWith(
                                  fontSize: 10.sp,
                                  color: ConstantColors.secondaryTextColor,
                                ),
                              ),
                            ),
                          ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: Get.width * 0.7,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: isMe
                                ? ConstantColors.primaryButtonColor
                                : ConstantColors.containerColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
                              bottomLeft: isMe
                                  ? Radius.circular(16.r)
                                  : Radius.circular(4.r),
                              bottomRight: isMe
                                  ? Radius.circular(4.r)
                                  : Radius.circular(16.r),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.message,
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: isMe
                                      ? Colors.white
                                      : ConstantColors.secondaryButtonColor,
                                ),
                              ),
                              if (isMe)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      message.isRead
                                          ? Icons.done_all
                                          : Icons.done,
                                      size: 14.sp,
                                      color: message.isRead
                                          ? Colors.blue
                                          : Colors.white70,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),

          // Message Input
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: ConstantColors.containerColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: context.textTheme.bodyMedium,
                    maxLines: 5,
                    minLines: 1,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: context.textTheme.bodySmall!.copyWith(
                        color: ConstantColors.secondaryTextColor,
                      ),
                      filled: true,
                      fillColor: ConstantColors.backgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide(
                          color: ConstantColors.primaryButtonColor,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Obx(
                  () => CircleAvatar(
                    radius: 24.r,
                    backgroundColor: ConstantColors.primaryButtonColor,
                    child: _chatController.isSending
                        ? SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : IconButton(
                            icon: const Icon(Icons.send, color: Colors.white),
                            padding: EdgeInsets.zero,
                            onPressed: _sendMessage,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
