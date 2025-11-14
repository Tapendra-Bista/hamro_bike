import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/utils/timestamps_convertor.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';


@freezed
abstract class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String name,
    required String email,
    required String profile,
    @TimestampConverter() required DateTime createdAt,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}

extension ProfileModelExtension on ProfileModel {
  Map<String, dynamic> toMap() => toJson();
}


// commmand to generate code 
// dart run build_runner  watch -d