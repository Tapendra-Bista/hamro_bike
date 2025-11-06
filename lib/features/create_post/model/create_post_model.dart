import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamro_bike/common/utils/timestamps_convertor.dart';
part 'create_post_model.freezed.dart';
part 'create_post_model.g.dart';

@freezed
abstract class CreatePostModel with _$CreatePostModel {
  const factory CreatePostModel({
    required String uId,
    required String title,
    required String vehicleName,
    required String description,
    required double price,
    required String location,
    required List<String> imageUrls,
    @TimestampConverter()
    required DateTime postDate,
    required double usedDurationInYears,

  }) = _CreatePostModel;
  factory CreatePostModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePostModelFromJson(json);
}

extension CreatePostModelX on CreatePostModel {
  Map<String, dynamic> toMap() => toJson();
}