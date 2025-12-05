import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamro_bike/common/utils/timestamps_convertor.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
abstract class ChatModel with _$ChatModel {
  const factory ChatModel({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String lastMessage,
    @TimestampConverter() required DateTime lastMessageTime,
    @Default(0) int unreadCount,
    required String postId,
    required String postTitle,
    required String postImageUrl,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}

extension ChatModelX on ChatModel {
  Map<String, dynamic> toMap() => toJson();
}
