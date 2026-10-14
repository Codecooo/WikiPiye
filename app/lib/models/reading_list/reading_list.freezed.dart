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

 String get id; String get title; String? get description; List<String> get articleIds; DateTime get createdAt; DateTime get updatedAt;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingList&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&const DeepCollectionEquality().equals(other.articleIds, _this.articleIds)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingList;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,const DeepCollectionEquality().hash(_this.articleIds),_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as ReadingList;
  return 'ReadingList(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, articleIds: ${_this.articleIds}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $ReadingListCopyWith<$Res>  {
  factory $ReadingListCopyWith(ReadingList value, $Res Function(ReadingList) _then) = _$ReadingListCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, List<String> articleIds, DateTime createdAt, DateTime updatedAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? articleIds = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(ReadingList(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,articleIds: null == articleIds ? _self.articleIds : articleIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  List<String> articleIds,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingList() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.articleIds,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  List<String> articleIds,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ReadingList():
return $default(_that.id,_that.title,_that.description,_that.articleIds,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  List<String> articleIds,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ReadingList() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.articleIds,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingList implements ReadingList {
  const _ReadingList({required this.id, required this.title, this.description,  List<String> articleIds = const [], required this.createdAt, required this.updatedAt}): _articleIds = articleIds;
  factory _ReadingList.fromJson(Map<String, dynamic> json) => _$ReadingListFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? description;
 final  List<String> _articleIds;
@override@JsonKey() List<String> get articleIds {
  if (_articleIds is EqualUnmodifiableListView) return _articleIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articleIds);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;

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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingList&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.articleIds, _articleIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,const DeepCollectionEquality().hash(_articleIds),createdAt,updatedAt);
}

@override
String toString() {
    return 'ReadingList(id: $id, title: $title, description: $description, articleIds: $articleIds, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ReadingListCopyWith<$Res> implements $ReadingListCopyWith<$Res> {
  factory _$ReadingListCopyWith(_ReadingList value, $Res Function(_ReadingList) _then) = __$ReadingListCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, List<String> articleIds, DateTime createdAt, DateTime updatedAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? articleIds = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ReadingList(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,articleIds: null == articleIds ? _self._articleIds : articleIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
