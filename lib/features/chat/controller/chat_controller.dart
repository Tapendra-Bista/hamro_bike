import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_bike/common/widgets/snackbar.dart';
import 'package:hamro_bike/features/authentication/controllers/authentication_controllers.dart';
import 'package:hamro_bike/features/chat/model/chat_model.dart';
import 'package:hamro_bike/features/chat/model/message_model.dart';
import 'package:hamro_bike/features/chat/repository/chat_repository.dart';
import 'package:logger/logger.dart';

class ChatController extends GetxController {
  // Instance
  final ChatRepository _chatRepository = ChatRepository();
  final Logger _logger = Logger();
  final AuthenticationController _authController =
      Get.find<AuthenticationController>();

  // Variables
  final RxList<ChatModel> _chatsList = <ChatModel>[].obs;
  final RxList<MessageModel> _messages = <MessageModel>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isSending = false.obs;
  StreamSubscription? _chatsSubscription;
  StreamSubscription? _messagesSubscription;

  // Getters
  List<ChatModel> get chatsList => _chatsList;
  List<MessageModel> get messages => _messages;
  bool get isLoading => _isLoading.value;
  bool get isSending => _isSending.value;
  String get currentUserId => _authController.currentUserId ?? '';

  // Setters
  set chatsList(List<ChatModel> value) => _chatsList.value = value;
  set messages(List<MessageModel> value) => _messages.value = value;
  set isLoading(bool value) => _isLoading.value = value;
  set isSending(bool value) => _isSending.value = value;

  @override
  void onInit() {
    super.onInit();
    fetchUserChats();
  }

  @override
  void onClose() {
    _chatsSubscription?.cancel();
    _messagesSubscription?.cancel();
    super.onClose();
  }

  // Fetch user chats
  void fetchUserChats() {
    try {
      if (currentUserId.isEmpty) {
        _logger.w('Cannot fetch chats: User not logged in');
        return;
      }

      isLoading = true;
      _chatsSubscription?.cancel();
      _chatsSubscription = _chatRepository
          .getUserChats(currentUserId)
          .listen(
            (chats) {
              chatsList = chats;
              isLoading = false;
            },
            onError: (e) {
              _logger.e('Error fetching chats: $e');
              snackbar('Error loading chats', Colors.red);
              isLoading = false;
            },
          );
    } catch (e) {
      _logger.e('Error in fetchUserChats: $e');
      isLoading = false;
    }
  }

  // Fetch messages for a chat
  void fetchChatMessages(String chatId) {
    try {
      _messagesSubscription?.cancel();
      _messagesSubscription = _chatRepository
          .getChatMessages(chatId)
          .listen(
            (msgs) {
              messages = msgs;
            },
            onError: (e) {
              _logger.e('Error fetching messages: $e');
              snackbar('Error loading messages', Colors.red);
            },
          );
    } catch (e) {
      _logger.e('Error in fetchChatMessages: $e');
    }
  }

  // Send message
  Future<void> sendMessage({
    required String chatId,
    required String receiverId,
    required String message,
  }) async {
    if (message.trim().isEmpty) return;

    try {
      isSending = true;
      await _chatRepository.sendMessage(
        chatId: chatId,
        senderId: currentUserId,
        receiverId: receiverId,
        message: message,
      );
    } catch (e) {
      _logger.e('Error sending message: $e');
      snackbar('Failed to send message', Colors.red);
    } finally {
      isSending = false;
    }
  }

  // Create or get chat
  Future<String?> createOrGetChat({
    required String receiverId,
    required String postId,
    required String postTitle,
    required String postImageUrl,
  }) async {
    try {
      if (currentUserId.isEmpty) {
        snackbar('Please login to chat', Colors.red);
        return null;
      }

      final chatId = await _chatRepository.createOrGetChat(
        senderId: currentUserId,
        receiverId: receiverId,
        postId: postId,
        postTitle: postTitle,
        postImageUrl: postImageUrl,
      );
      return chatId;
    } catch (e) {
      _logger.e('Error creating/getting chat: $e');
      snackbar('Failed to start chat', Colors.red);
      return null;
    }
  }

  // Mark messages as read
  Future<void> markMessagesAsRead(String chatId) async {
    try {
      await _chatRepository.markMessagesAsRead(chatId, currentUserId);
    } catch (e) {
      _logger.e('Error marking messages as read: $e');
    }
  }

  // Delete chat
  Future<void> deleteChat(String chatId) async {
    try {
      await _chatRepository.deleteChat(chatId);
      snackbar('Chat deleted', Colors.green);
    } catch (e) {
      _logger.e('Error deleting chat: $e');
      snackbar('Failed to delete chat', Colors.red);
    }
  }

  // Get other user ID from chat
  String getOtherUserId(ChatModel chat) {
    return chat.senderId == currentUserId ? chat.receiverId : chat.senderId;
  }
}
