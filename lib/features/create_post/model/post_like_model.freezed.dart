// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_like_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostLikeModel implements DiagnosticableTreeMixin {

 List<String> get likeId;
/// Create a copy of PostLikeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostLikeModelCopyWith<PostLikeModel> get copyWith => _$PostLikeModelCopyWithImpl<PostLikeModel>(this as PostLikeModel, _$identity);

  /// Serializes this PostLikeModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PostLikeModel'))
    ..add(DiagnosticsProperty('likeId', likeId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostLikeModel&&const DeepCollectionEquality().equals(other.likeId, likeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(likeId));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PostLikeModel(likeId: $likeId)';
}


}

/// @nodoc
abstract mixin class $PostLikeModelCopyWith<$Res>  {
  factory $PostLikeModelCopyWith(PostLikeModel value, $Res Function(PostLikeModel) _then) = _$PostLikeModelCopyWithImpl;
@useResult
$Res call({
 List<String> likeId
});




}
/// @nodoc
class _$PostLikeModelCopyWithImpl<$Res>
    implements $PostLikeModelCopyWith<$Res> {
  _$PostLikeModelCopyWithImpl(this._self, this._then);

  final PostLikeModel _self;
  final $Res Function(PostLikeModel) _then;

/// Create a copy of PostLikeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? likeId = null,}) {
  return _then(_self.copyWith(
likeId: null == likeId ? _self.likeId : likeId // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PostLikeModel].
extension PostLikeModelPatterns on PostLikeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostLikeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostLikeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostLikeModel value)  $default,){
final _that = this;
switch (_that) {
case _PostLikeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostLikeModel value)?  $default,){
final _that = this;
switch (_that) {
case _PostLikeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> likeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostLikeModel() when $default != null:
return $default(_that.likeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> likeId)  $default,) {final _that = this;
switch (_that) {
case _PostLikeModel():
return $default(_that.likeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> likeId)?  $default,) {final _that = this;
switch (_that) {
case _PostLikeModel() when $default != null:
return $default(_that.likeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostLikeModel with DiagnosticableTreeMixin implements PostLikeModel {
  const _PostLikeModel({required final  List<String> likeId}): _likeId = likeId;
  factory _PostLikeModel.fromJson(Map<String, dynamic> json) => _$PostLikeModelFromJson(json);

 final  List<String> _likeId;
@override List<String> get likeId {
  if (_likeId is EqualUnmodifiableListView) return _likeId;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_likeId);
}


/// Create a copy of PostLikeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostLikeModelCopyWith<_PostLikeModel> get copyWith => __$PostLikeModelCopyWithImpl<_PostLikeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostLikeModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PostLikeModel'))
    ..add(DiagnosticsProperty('likeId', likeId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostLikeModel&&const DeepCollectionEquality().equals(other._likeId, _likeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_likeId));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PostLikeModel(likeId: $likeId)';
}


}

/// @nodoc
abstract mixin class _$PostLikeModelCopyWith<$Res> implements $PostLikeModelCopyWith<$Res> {
  factory _$PostLikeModelCopyWith(_PostLikeModel value, $Res Function(_PostLikeModel) _then) = __$PostLikeModelCopyWithImpl;
@override @useResult
$Res call({
 List<String> likeId
});




}
/// @nodoc
class __$PostLikeModelCopyWithImpl<$Res>
    implements _$PostLikeModelCopyWith<$Res> {
  __$PostLikeModelCopyWithImpl(this._self, this._then);

  final _PostLikeModel _self;
  final $Res Function(_PostLikeModel) _then;

/// Create a copy of PostLikeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? likeId = null,}) {
  return _then(_PostLikeModel(
likeId: null == likeId ? _self._likeId : likeId // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
