// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReadingList {

 String get userId; String get articleId; DateTime get createdAt;
/// Create a copy of ReadingList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingListCopyWith<ReadingList> get copyWith => _$ReadingListCopyWithImpl<ReadingList>(this as ReadingList, _$identity);

  /// Serializes this ReadingList to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingList;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingList&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.articleId, _this.articleId) || other.articleId == _this.articleId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingList;
  return Object.hash(runtimeType,_this.userId,_this.articleId,_this.createdAt);
}

@override
String toString() {
  final _this = this as ReadingList;
  return 'ReadingList(userId: ${_this.userId}, articleId: ${_this.articleId}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ReadingListCopyWith<$Res>  {
  factory $ReadingListCopyWith(ReadingList value, $Res Function(ReadingList) _then) = _$ReadingListCopyWithImpl;
@useResult
$Res call({
 String userId, String articleId, DateTime createdAt
});




}
/// @nodoc
class _$ReadingListCopyWithImpl<$Res>
    implements $ReadingListCopyWith<$Res> {
  _$ReadingListCopyWithImpl(this._self, this._then);

  final ReadingList _self;
  final $Res Function(ReadingList) _then;

/// Create a copy of ReadingList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? articleId = null,Object? createdAt = null,}) {
  return _then(ReadingList(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,articleId: null == articleId ? _self.articleId : articleId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingList].
extension ReadingListPatterns on ReadingList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingList value)  $default,){
final _that = this;
switch (_that) {
case _ReadingList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingList value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String articleId,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingList() when $default != null:
return $default(_that.userId,_that.articleId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String articleId,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ReadingList():
return $default(_that.userId,_that.articleId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String articleId,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ReadingList() when $default != null:
return $default(_that.userId,_that.articleId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingList implements ReadingList {
  const _ReadingList({required this.userId, required this.articleId, required this.createdAt});
  factory _ReadingList.fromJson(Map<String, dynamic> json) => _$ReadingListFromJson(json);

@override final  String userId;
@override final  String articleId;
@override final  DateTime createdAt;

/// Create a copy of ReadingList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingListCopyWith<_ReadingList> get copyWith => __$ReadingListCopyWithImpl<_ReadingList>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingListToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingList&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.articleId, articleId) || other.articleId == articleId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,articleId,createdAt);
}

@override
String toString() {
    return 'ReadingList(userId: $userId, articleId: $articleId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ReadingListCopyWith<$Res> implements $ReadingListCopyWith<$Res> {
  factory _$ReadingListCopyWith(_ReadingList value, $Res Function(_ReadingList) _then) = __$ReadingListCopyWithImpl;
@override @useResult
$Res call({
 String userId, String articleId, DateTime createdAt
});




}
/// @nodoc
class __$ReadingListCopyWithImpl<$Res>
    implements _$ReadingListCopyWith<$Res> {
  __$ReadingListCopyWithImpl(this._self, this._then);

  final _ReadingList _self;
  final $Res Function(_ReadingList) _then;

/// Create a copy of ReadingList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? articleId = null,Object? createdAt = null,}) {
  return _then(_ReadingList(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,articleId: null == articleId ? _self.articleId : articleId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
