import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamro_bike/common/utils/timestamps_convertor.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String messageId,
    required String chatId,
    required String senderId,
    required String receiverId,
    required String message,
    @TimestampConverter() required DateTime timestamp,
    @Default(false) bool isRead,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}

extension MessageModelX on MessageModel {
  Map<String, dynamic> toMap() => toJson();
}
