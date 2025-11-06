import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/utils/timestamps_convertor.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

/*      final userData = <String, dynamic>{
        'uid': user.uid,
        'email': user.email ?? '',
        'name': user.displayName ?? '',
        'profile': user.photoURL ?? '',
        'createdAt': DateTime.now(),
        // Add other user fields as necessary
      };*/
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