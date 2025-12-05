import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamro_bike/common/utils/timestamps_convertor.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
abstract class CommentModel with _$CommentModel {
  const factory CommentModel({
    required String commentId,
    required String postId,
    required String userId,
    required String userName,
    required String userProfile,
    required String comment,
    @TimestampConverter() required DateTime timestamp,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}

extension CommentModelX on CommentModel {
  Map<String, dynamic> toMap() => toJson();
}
