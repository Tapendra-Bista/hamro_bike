import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hamro_bike/features/chat/model/chat_model.dart';
import 'package:hamro_bike/features/chat/model/message_model.dart';
import 'package:hamro_bike/services/base_repository.dart';

class ChatRepository extends BaseRepository {
  // Get all chats for current user
  Stream<List<ChatModel>> getUserChats(String userId) {
    try {
      return firestore
          .collection('chats')
          .where('participants', arrayContains: userId)
          .snapshots()
          .map((snapshot) {
            final chats = snapshot.docs
                .map((doc) => ChatModel.fromJson(doc.data()))
                .toList();

            // Sort locally by lastMessageTime instead of using Firestore orderBy
            chats.sort(
              (a, b) => b.lastMessageTime.compareTo(a.lastMessageTime),
            );
            return chats;
          });
    } catch (e) {
      rethrow;
    }
  }

  // Get messages for a specific chat
  Stream<List<MessageModel>> getChatMessages(String chatId) {
    try {
      return firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs
                .map((doc) => MessageModel.fromJson(doc.data()))
                .toList();
          });
    } catch (e) {
      rethrow;
    }
  }

  // Send a message
  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    try {
      final messageId = firestore.collection('chats').doc().id;
      final timestamp = DateTime.now();

      // Add message to chat messages subcollection
      await firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .set({
            'messageId': messageId,
            'chatId': chatId,
            'senderId': senderId,
            'receiverId': receiverId,
            'message': message,
            'timestamp': Timestamp.fromDate(timestamp),
            'isRead': false,
          });

      // Update chat document with last message and increment unread count
      final chatDoc = await firestore.collection('chats').doc(chatId).get();
      final currentUnread = chatDoc.data()?['unreadCount'] ?? 0;

      await firestore.collection('chats').doc(chatId).update({
        'lastMessage': message,
        'lastMessageTime': Timestamp.fromDate(timestamp),
        'unreadCount': currentUnread + 1,
      });
    } catch (e) {
      rethrow;
    }
  }

  // Create or get existing chat
  Future<String> createOrGetChat({
    required String senderId,
    required String receiverId,
    required String postId,
    required String postTitle,
    required String postImageUrl,
  }) async {
    try {
      // Check if chat already exists
      final existingChat = await firestore
          .collection('chats')
          .where('postId', isEqualTo: postId)
          .where('participants', arrayContains: senderId)
          .get();

      for (var doc in existingChat.docs) {
        final participants = List<String>.from(doc.data()['participants']);
        if (participants.contains(receiverId)) {
          return doc.id;
        }
      }

      // Create new chat
      final chatId = firestore.collection('chats').doc().id;
      await firestore.collection('chats').doc(chatId).set({
        'chatId': chatId,
        'senderId': senderId,
        'receiverId': receiverId,
        'participants': [senderId, receiverId],
        'postId': postId,
        'postTitle': postTitle,
        'postImageUrl': postImageUrl,
        'lastMessage': '',
        'lastMessageTime': Timestamp.fromDate(DateTime.now()),
        'unreadCount': 0,
      });

      return chatId;
    } catch (e) {
      rethrow;
    }
  }

  // Mark messages as read
  Future<void> markMessagesAsRead(String chatId, String userId) async {
    try {
      final unreadMessages = await firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .where('receiverId', isEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .get();

      final batch = firestore.batch();
      for (var doc in unreadMessages.docs) {
        batch.update(doc.reference, {'isRead': true});
      }

      // Reset unread count in chat document
      batch.update(firestore.collection('chats').doc(chatId), {
        'unreadCount': 0,
      });

      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }

  // Delete chat
  Future<void> deleteChat(String chatId) async {
    try {
      // Delete all messages
      final messages = await firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .get();

      final batch = firestore.batch();
      for (var doc in messages.docs) {
        batch.delete(doc.reference);
      }

      // Delete chat document
      batch.delete(firestore.collection('chats').doc(chatId));
      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }
}
