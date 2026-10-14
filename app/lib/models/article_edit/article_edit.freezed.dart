// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_edit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArticleEdit {

 String get id; String get articleId; String get title; String get editSummary; List<Map<String, dynamic>> get contentDelta; String? get editorId; String? get editorIpAddress; DateTime get editedAt;
/// Create a copy of ArticleEdit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleEditCopyWith<ArticleEdit> get copyWith => _$ArticleEditCopyWithImpl<ArticleEdit>(this as ArticleEdit, _$identity);

  /// Serializes this ArticleEdit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ArticleEdit;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleEdit&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.articleId, _this.articleId) || other.articleId == _this.articleId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.editSummary, _this.editSummary) || other.editSummary == _this.editSummary)&&const DeepCollectionEquality().equals(other.contentDelta, _this.contentDelta)&&(identical(other.editorId, _this.editorId) || other.editorId == _this.editorId)&&(identical(other.editorIpAddress, _this.editorIpAddress) || other.editorIpAddress == _this.editorIpAddress)&&(identical(other.editedAt, _this.editedAt) || other.editedAt == _this.editedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ArticleEdit;
  return Object.hash(runtimeType,_this.id,_this.articleId,_this.title,_this.editSummary,const DeepCollectionEquality().hash(_this.contentDelta),_this.editorId,_this.editorIpAddress,_this.editedAt);
}

@override
String toString() {
  final _this = this as ArticleEdit;
  return 'ArticleEdit(id: ${_this.id}, articleId: ${_this.articleId}, title: ${_this.title}, editSummary: ${_this.editSummary}, contentDelta: ${_this.contentDelta}, editorId: ${_this.editorId}, editorIpAddress: ${_this.editorIpAddress}, editedAt: ${_this.editedAt})';
}


}

/// @nodoc
abstract mixin class $ArticleEditCopyWith<$Res>  {
  factory $ArticleEditCopyWith(ArticleEdit value, $Res Function(ArticleEdit) _then) = _$ArticleEditCopyWithImpl;
@useResult
$Res call({
 String id, String articleId, String title, String editSummary, List<Map<String, dynamic>> contentDelta, String? editorId, String? editorIpAddress, DateTime editedAt
});




}
/// @nodoc
class _$ArticleEditCopyWithImpl<$Res>
    implements $ArticleEditCopyWith<$Res> {
  _$ArticleEditCopyWithImpl(this._self, this._then);

  final ArticleEdit _self;
  final $Res Function(ArticleEdit) _then;

/// Create a copy of ArticleEdit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? articleId = null,Object? title = null,Object? editSummary = null,Object? contentDelta = null,Object? editorId = freezed,Object? editorIpAddress = freezed,Object? editedAt = null,}) {
  return _then(ArticleEdit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,articleId: null == articleId ? _self.articleId : articleId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,editSummary: null == editSummary ? _self.editSummary : editSummary // ignore: cast_nullable_to_non_nullable
as String,contentDelta: null == contentDelta ? _self.contentDelta : contentDelta // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,editorId: freezed == editorId ? _self.editorId : editorId // ignore: cast_nullable_to_non_nullable
as String?,editorIpAddress: freezed == editorIpAddress ? _self.editorIpAddress : editorIpAddress // ignore: cast_nullable_to_non_nullable
as String?,editedAt: null == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleEdit].
extension ArticleEditPatterns on ArticleEdit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleEdit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleEdit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleEdit value)  $default,){
final _that = this;
switch (_that) {
case _ArticleEdit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleEdit value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleEdit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String articleId,  String title,  String editSummary,  List<Map<String, dynamic>> contentDelta,  String? editorId,  String? editorIpAddress,  DateTime editedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleEdit() when $default != null:
return $default(_that.id,_that.articleId,_that.title,_that.editSummary,_that.contentDelta,_that.editorId,_that.editorIpAddress,_that.editedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String articleId,  String title,  String editSummary,  List<Map<String, dynamic>> contentDelta,  String? editorId,  String? editorIpAddress,  DateTime editedAt)  $default,) {final _that = this;
switch (_that) {
case _ArticleEdit():
return $default(_that.id,_that.articleId,_that.title,_that.editSummary,_that.contentDelta,_that.editorId,_that.editorIpAddress,_that.editedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String articleId,  String title,  String editSummary,  List<Map<String, dynamic>> contentDelta,  String? editorId,  String? editorIpAddress,  DateTime editedAt)?  $default,) {final _that = this;
switch (_that) {
case _ArticleEdit() when $default != null:
return $default(_that.id,_that.articleId,_that.title,_that.editSummary,_that.contentDelta,_that.editorId,_that.editorIpAddress,_that.editedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticleEdit implements ArticleEdit {
  const _ArticleEdit({required this.id, required this.articleId, required this.title, required this.editSummary, required  List<Map<String, dynamic>> contentDelta, this.editorId, this.editorIpAddress, required this.editedAt}): _contentDelta = contentDelta;
  factory _ArticleEdit.fromJson(Map<String, dynamic> json) => _$ArticleEditFromJson(json);

@override final  String id;
@override final  String articleId;
@override final  String title;
@override final  String editSummary;
 final  List<Map<String, dynamic>> _contentDelta;
@override List<Map<String, dynamic>> get contentDelta {
  if (_contentDelta is EqualUnmodifiableListView) return _contentDelta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contentDelta);
}

@override final  String? editorId;
@override final  String? editorIpAddress;
@override final  DateTime editedAt;

/// Create a copy of ArticleEdit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleEditCopyWith<_ArticleEdit> get copyWith => __$ArticleEditCopyWithImpl<_ArticleEdit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleEditToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleEdit&&(identical(other.id, id) || other.id == id)&&(identical(other.articleId, articleId) || other.articleId == articleId)&&(identical(other.title, title) || other.title == title)&&(identical(other.editSummary, editSummary) || other.editSummary == editSummary)&&const DeepCollectionEquality().equals(other.contentDelta, _contentDelta)&&(identical(other.editorId, editorId) || other.editorId == editorId)&&(identical(other.editorIpAddress, editorIpAddress) || other.editorIpAddress == editorIpAddress)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,articleId,title,editSummary,const DeepCollectionEquality().hash(_contentDelta),editorId,editorIpAddress,editedAt);
}

@override
String toString() {
    return 'ArticleEdit(id: $id, articleId: $articleId, title: $title, editSummary: $editSummary, contentDelta: $contentDelta, editorId: $editorId, editorIpAddress: $editorIpAddress, editedAt: $editedAt)';
}


}

/// @nodoc
abstract mixin class _$ArticleEditCopyWith<$Res> implements $ArticleEditCopyWith<$Res> {
  factory _$ArticleEditCopyWith(_ArticleEdit value, $Res Function(_ArticleEdit) _then) = __$ArticleEditCopyWithImpl;
@override @useResult
$Res call({
 String id, String articleId, String title, String editSummary, List<Map<String, dynamic>> contentDelta, String? editorId, String? editorIpAddress, DateTime editedAt
});




}
/// @nodoc
class __$ArticleEditCopyWithImpl<$Res>
    implements _$ArticleEditCopyWith<$Res> {
  __$ArticleEditCopyWithImpl(this._self, this._then);

  final _ArticleEdit _self;
  final $Res Function(_ArticleEdit) _then;

/// Create a copy of ArticleEdit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? articleId = null,Object? title = null,Object? editSummary = null,Object? contentDelta = null,Object? editorId = freezed,Object? editorIpAddress = freezed,Object? editedAt = null,}) {
  return _then(_ArticleEdit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,articleId: null == articleId ? _self.articleId : articleId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,editSummary: null == editSummary ? _self.editSummary : editSummary // ignore: cast_nullable_to_non_nullable
as String,contentDelta: null == contentDelta ? _self._contentDelta : contentDelta // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,editorId: freezed == editorId ? _self.editorId : editorId // ignore: cast_nullable_to_non_nullable
as String?,editorIpAddress: freezed == editorIpAddress ? _self.editorIpAddress : editorIpAddress // ignore: cast_nullable_to_non_nullable
as String?,editedAt: null == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
