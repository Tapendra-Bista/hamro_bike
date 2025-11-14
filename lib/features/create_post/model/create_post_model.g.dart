// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatePostModel _$CreatePostModelFromJson(Map<String, dynamic> json) =>
    _CreatePostModel(
      postId: json['postId'] as String,
      uId: json['uId'] as String,
      title: json['title'] as String,
      vehicleName: json['vehicleName'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      location: json['location'] as String,
      status: json['status'] as String? ?? 'available',
      imageUrls: (json['imageUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      postDate: const TimestampConverter().fromJson(json['postDate']),
      usedDurationInYears: (json['usedDurationInYears'] as num).toDouble(),
    );

Map<String, dynamic> _$CreatePostModelToJson(_CreatePostModel instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'uId': instance.uId,
      'title': instance.title,
      'vehicleName': instance.vehicleName,
      'description': instance.description,
      'price': instance.price,
      'location': instance.location,
      'status': instance.status,
      'imageUrls': instance.imageUrls,
      'postDate': const TimestampConverter().toJson(instance.postDate),
      'usedDurationInYears': instance.usedDurationInYears,
    };
