// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreatePostModel {

 String get uId; String get title; String get vehicleName; String get description; double get price; String get location; List<String> get imageUrls;@TimestampConverter() DateTime get postDate; double get usedDurationInYears;
/// Create a copy of CreatePostModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePostModelCopyWith<CreatePostModel> get copyWith => _$CreatePostModelCopyWithImpl<CreatePostModel>(this as CreatePostModel, _$identity);

  /// Serializes this CreatePostModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePostModel&&(identical(other.uId, uId) || other.uId == uId)&&(identical(other.title, title) || other.title == title)&&(identical(other.vehicleName, vehicleName) || other.vehicleName == vehicleName)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.postDate, postDate) || other.postDate == postDate)&&(identical(other.usedDurationInYears, usedDurationInYears) || other.usedDurationInYears == usedDurationInYears));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uId,title,vehicleName,description,price,location,const DeepCollectionEquality().hash(imageUrls),postDate,usedDurationInYears);

@override
String toString() {
  return 'CreatePostModel(uId: $uId, title: $title, vehicleName: $vehicleName, description: $description, price: $price, location: $location, imageUrls: $imageUrls, postDate: $postDate, usedDurationInYears: $usedDurationInYears)';
}


}

/// @nodoc
abstract mixin class $CreatePostModelCopyWith<$Res>  {
  factory $CreatePostModelCopyWith(CreatePostModel value, $Res Function(CreatePostModel) _then) = _$CreatePostModelCopyWithImpl;
@useResult
$Res call({
 String uId, String title, String vehicleName, String description, double price, String location, List<String> imageUrls,@TimestampConverter() DateTime postDate, double usedDurationInYears
});




}
/// @nodoc
class _$CreatePostModelCopyWithImpl<$Res>
    implements $CreatePostModelCopyWith<$Res> {
  _$CreatePostModelCopyWithImpl(this._self, this._then);

  final CreatePostModel _self;
  final $Res Function(CreatePostModel) _then;

/// Create a copy of CreatePostModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uId = null,Object? title = null,Object? vehicleName = null,Object? description = null,Object? price = null,Object? location = null,Object? imageUrls = null,Object? postDate = null,Object? usedDurationInYears = null,}) {
  return _then(_self.copyWith(
uId: null == uId ? _self.uId : uId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,vehicleName: null == vehicleName ? _self.vehicleName : vehicleName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,postDate: null == postDate ? _self.postDate : postDate // ignore: cast_nullable_to_non_nullable
as DateTime,usedDurationInYears: null == usedDurationInYears ? _self.usedDurationInYears : usedDurationInYears // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePostModel].
extension CreatePostModelPatterns on CreatePostModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePostModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePostModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePostModel value)  $default,){
final _that = this;
switch (_that) {
case _CreatePostModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePostModel value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePostModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uId,  String title,  String vehicleName,  String description,  double price,  String location,  List<String> imageUrls, @TimestampConverter()  DateTime postDate,  double usedDurationInYears)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePostModel() when $default != null:
return $default(_that.uId,_that.title,_that.vehicleName,_that.description,_that.price,_that.location,_that.imageUrls,_that.postDate,_that.usedDurationInYears);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uId,  String title,  String vehicleName,  String description,  double price,  String location,  List<String> imageUrls, @TimestampConverter()  DateTime postDate,  double usedDurationInYears)  $default,) {final _that = this;
switch (_that) {
case _CreatePostModel():
return $default(_that.uId,_that.title,_that.vehicleName,_that.description,_that.price,_that.location,_that.imageUrls,_that.postDate,_that.usedDurationInYears);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uId,  String title,  String vehicleName,  String description,  double price,  String location,  List<String> imageUrls, @TimestampConverter()  DateTime postDate,  double usedDurationInYears)?  $default,) {final _that = this;
switch (_that) {
case _CreatePostModel() when $default != null:
return $default(_that.uId,_that.title,_that.vehicleName,_that.description,_that.price,_that.location,_that.imageUrls,_that.postDate,_that.usedDurationInYears);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePostModel implements CreatePostModel {
  const _CreatePostModel({required this.uId, required this.title, required this.vehicleName, required this.description, required this.price, required this.location, required final  List<String> imageUrls, @TimestampConverter() required this.postDate, required this.usedDurationInYears}): _imageUrls = imageUrls;
  factory _CreatePostModel.fromJson(Map<String, dynamic> json) => _$CreatePostModelFromJson(json);

@override final  String uId;
@override final  String title;
@override final  String vehicleName;
@override final  String description;
@override final  double price;
@override final  String location;
 final  List<String> _imageUrls;
@override List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

@override@TimestampConverter() final  DateTime postDate;
@override final  double usedDurationInYears;

/// Create a copy of CreatePostModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePostModelCopyWith<_CreatePostModel> get copyWith => __$CreatePostModelCopyWithImpl<_CreatePostModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePostModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePostModel&&(identical(other.uId, uId) || other.uId == uId)&&(identical(other.title, title) || other.title == title)&&(identical(other.vehicleName, vehicleName) || other.vehicleName == vehicleName)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.postDate, postDate) || other.postDate == postDate)&&(identical(other.usedDurationInYears, usedDurationInYears) || other.usedDurationInYears == usedDurationInYears));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uId,title,vehicleName,description,price,location,const DeepCollectionEquality().hash(_imageUrls),postDate,usedDurationInYears);

@override
String toString() {
  return 'CreatePostModel(uId: $uId, title: $title, vehicleName: $vehicleName, description: $description, price: $price, location: $location, imageUrls: $imageUrls, postDate: $postDate, usedDurationInYears: $usedDurationInYears)';
}


}

/// @nodoc
abstract mixin class _$CreatePostModelCopyWith<$Res> implements $CreatePostModelCopyWith<$Res> {
  factory _$CreatePostModelCopyWith(_CreatePostModel value, $Res Function(_CreatePostModel) _then) = __$CreatePostModelCopyWithImpl;
@override @useResult
$Res call({
 String uId, String title, String vehicleName, String description, double price, String location, List<String> imageUrls,@TimestampConverter() DateTime postDate, double usedDurationInYears
});




}
/// @nodoc
class __$CreatePostModelCopyWithImpl<$Res>
    implements _$CreatePostModelCopyWith<$Res> {
  __$CreatePostModelCopyWithImpl(this._self, this._then);

  final _CreatePostModel _self;
  final $Res Function(_CreatePostModel) _then;

/// Create a copy of CreatePostModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uId = null,Object? title = null,Object? vehicleName = null,Object? description = null,Object? price = null,Object? location = null,Object? imageUrls = null,Object? postDate = null,Object? usedDurationInYears = null,}) {
  return _then(_CreatePostModel(
uId: null == uId ? _self.uId : uId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,vehicleName: null == vehicleName ? _self.vehicleName : vehicleName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,postDate: null == postDate ? _self.postDate : postDate // ignore: cast_nullable_to_non_nullable
as DateTime,usedDurationInYears: null == usedDurationInYears ? _self.usedDurationInYears : usedDurationInYears // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
