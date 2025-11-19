// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_like_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostLikeModel _$PostLikeModelFromJson(Map<String, dynamic> json) =>
    _PostLikeModel(
      likeId: (json['likeId'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PostLikeModelToJson(_PostLikeModel instance) =>
    <String, dynamic>{'likeId': instance.likeId};
