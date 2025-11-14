import 'package:freezed_annotation/freezed_annotation.dart';

part 'like_model.freezed.dart';
part 'like_model.g.dart';

@freezed
abstract class LikeModel with _$LikeModel {
  const factory LikeModel({required String postId, required String likeCount}) =
      _LikeModel;
  factory LikeModel.fromJson(Map<String, dynamic> json) =>
      _$LikeModelFromJson(json);
}

extension LikeModelX on LikeModel {
  Map<String, dynamic> toMap() => toJson();
}
