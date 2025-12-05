// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => _ChatModel(
  chatId: json['chatId'] as String,
  senderId: json['senderId'] as String,
  receiverId: json['receiverId'] as String,
  lastMessage: json['lastMessage'] as String,
  lastMessageTime: const TimestampConverter().fromJson(json['lastMessageTime']),
  unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
  postId: json['postId'] as String,
  postTitle: json['postTitle'] as String,
  postImageUrl: json['postImageUrl'] as String,
);

Map<String, dynamic> _$ChatModelToJson(_ChatModel instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'lastMessage': instance.lastMessage,
      'lastMessageTime': const TimestampConverter().toJson(
        instance.lastMessageTime,
      ),
      'unreadCount': instance.unreadCount,
      'postId': instance.postId,
      'postTitle': instance.postTitle,
      'postImageUrl': instance.postImageUrl,
    };
