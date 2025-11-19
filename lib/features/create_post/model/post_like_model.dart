import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'post_like_model.freezed.dart';
part 'post_like_model.g.dart';

@freezed
abstract class PostLikeModel  with _$PostLikeModel{

  const factory PostLikeModel({
    required List<String> likeId,


  }) = _PostLikeModel;
  factory PostLikeModel.fromJson(Map<String, dynamic> json) =>
      _$PostLikeModelFromJson(json);
}

extension CreatePostModelX on PostLikeModel {
  Map<String, dynamic> toMap() => toJson();
}