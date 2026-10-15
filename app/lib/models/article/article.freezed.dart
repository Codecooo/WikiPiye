// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Article {

 String get id; String get title; String get summary; String get bannerImageUrl; List<String> get category; EditProtectionLevel get editProtectionLevel; Map<String, dynamic> get infoboxData; List<ArticleSection> get sections; DateTime get createdAt; DateTime get updatedAt; int? get viewCount;
/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleCopyWith<Article> get copyWith => _$ArticleCopyWithImpl<Article>(this as Article, _$identity);

  /// Serializes this Article to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Article;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Article&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.bannerImageUrl, _this.bannerImageUrl) || other.bannerImageUrl == _this.bannerImageUrl)&&const DeepCollectionEquality().equals(other.category, _this.category)&&(identical(other.editProtectionLevel, _this.editProtectionLevel) || other.editProtectionLevel == _this.editProtectionLevel)&&const DeepCollectionEquality().equals(other.infoboxData, _this.infoboxData)&&const DeepCollectionEquality().equals(other.sections, _this.sections)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.viewCount, _this.viewCount) || other.viewCount == _this.viewCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Article;
  return Object.hash(runtimeType,_this.id,_this.title,_this.summary,_this.bannerImageUrl,const DeepCollectionEquality().hash(_this.category),_this.editProtectionLevel,const DeepCollectionEquality().hash(_this.infoboxData),const DeepCollectionEquality().hash(_this.sections),_this.createdAt,_this.updatedAt,_this.viewCount);
}

@override
String toString() {
  final _this = this as Article;
  return 'Article(id: ${_this.id}, title: ${_this.title}, summary: ${_this.summary}, bannerImageUrl: ${_this.bannerImageUrl}, category: ${_this.category}, editProtectionLevel: ${_this.editProtectionLevel}, infoboxData: ${_this.infoboxData}, sections: ${_this.sections}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, viewCount: ${_this.viewCount})';
}


}

/// @nodoc
abstract mixin class $ArticleCopyWith<$Res>  {
  factory $ArticleCopyWith(Article value, $Res Function(Article) _then) = _$ArticleCopyWithImpl;
@useResult
$Res call({
 String id, String title, String summary, String bannerImageUrl, List<String> category, EditProtectionLevel editProtectionLevel, Map<String, dynamic> infoboxData, List<ArticleSection> sections, DateTime createdAt, DateTime updatedAt, int? viewCount
});




}
/// @nodoc
class _$ArticleCopyWithImpl<$Res>
    implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._self, this._then);

  final Article _self;
  final $Res Function(Article) _then;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? summary = null,Object? bannerImageUrl = null,Object? category = null,Object? editProtectionLevel = null,Object? infoboxData = null,Object? sections = null,Object? createdAt = null,Object? updatedAt = null,Object? viewCount = freezed,}) {
  return _then(Article(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,bannerImageUrl: null == bannerImageUrl ? _self.bannerImageUrl : bannerImageUrl // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as List<String>,editProtectionLevel: null == editProtectionLevel ? _self.editProtectionLevel : editProtectionLevel // ignore: cast_nullable_to_non_nullable
as EditProtectionLevel,infoboxData: null == infoboxData ? _self.infoboxData : infoboxData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<ArticleSection>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,viewCount: freezed == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Article].
extension ArticlePatterns on Article {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Article value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Article() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Article value)  $default,){
final _that = this;
switch (_that) {
case _Article():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Article value)?  $default,){
final _that = this;
switch (_that) {
case _Article() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String summary,  String bannerImageUrl,  List<String> category,  EditProtectionLevel editProtectionLevel,  Map<String, dynamic> infoboxData,  List<ArticleSection> sections,  DateTime createdAt,  DateTime updatedAt,  int? viewCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that.id,_that.title,_that.summary,_that.bannerImageUrl,_that.category,_that.editProtectionLevel,_that.infoboxData,_that.sections,_that.createdAt,_that.updatedAt,_that.viewCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String summary,  String bannerImageUrl,  List<String> category,  EditProtectionLevel editProtectionLevel,  Map<String, dynamic> infoboxData,  List<ArticleSection> sections,  DateTime createdAt,  DateTime updatedAt,  int? viewCount)  $default,) {final _that = this;
switch (_that) {
case _Article():
return $default(_that.id,_that.title,_that.summary,_that.bannerImageUrl,_that.category,_that.editProtectionLevel,_that.infoboxData,_that.sections,_that.createdAt,_that.updatedAt,_that.viewCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String summary,  String bannerImageUrl,  List<String> category,  EditProtectionLevel editProtectionLevel,  Map<String, dynamic> infoboxData,  List<ArticleSection> sections,  DateTime createdAt,  DateTime updatedAt,  int? viewCount)?  $default,) {final _that = this;
switch (_that) {
case _Article() when $default != null:
return $default(_that.id,_that.title,_that.summary,_that.bannerImageUrl,_that.category,_that.editProtectionLevel,_that.infoboxData,_that.sections,_that.createdAt,_that.updatedAt,_that.viewCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Article implements Article {
  const _Article({required this.id, required this.title, required this.summary, required this.bannerImageUrl, required  List<String> category, required this.editProtectionLevel, required  Map<String, dynamic> infoboxData, required  List<ArticleSection> sections, required this.createdAt, required this.updatedAt, this.viewCount}): _category = category,_infoboxData = infoboxData,_sections = sections;
  factory _Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

@override final  String id;
@override final  String title;
@override final  String summary;
@override final  String bannerImageUrl;
 final  List<String> _category;
@override List<String> get category {
  if (_category is EqualUnmodifiableListView) return _category;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_category);
}

@override final  EditProtectionLevel editProtectionLevel;
 final  Map<String, dynamic> _infoboxData;
@override Map<String, dynamic> get infoboxData {
  if (_infoboxData is EqualUnmodifiableMapView) return _infoboxData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_infoboxData);
}

 final  List<ArticleSection> _sections;
@override List<ArticleSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  int? viewCount;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleCopyWith<_Article> get copyWith => __$ArticleCopyWithImpl<_Article>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Article&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.bannerImageUrl, bannerImageUrl) || other.bannerImageUrl == bannerImageUrl)&&const DeepCollectionEquality().equals(other.category, _category)&&(identical(other.editProtectionLevel, editProtectionLevel) || other.editProtectionLevel == editProtectionLevel)&&const DeepCollectionEquality().equals(other.infoboxData, _infoboxData)&&const DeepCollectionEquality().equals(other.sections, _sections)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,summary,bannerImageUrl,const DeepCollectionEquality().hash(_category),editProtectionLevel,const DeepCollectionEquality().hash(_infoboxData),const DeepCollectionEquality().hash(_sections),createdAt,updatedAt,viewCount);
}

@override
String toString() {
    return 'Article(id: $id, title: $title, summary: $summary, bannerImageUrl: $bannerImageUrl, category: $category, editProtectionLevel: $editProtectionLevel, infoboxData: $infoboxData, sections: $sections, createdAt: $createdAt, updatedAt: $updatedAt, viewCount: $viewCount)';
}


}

/// @nodoc
abstract mixin class _$ArticleCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$ArticleCopyWith(_Article value, $Res Function(_Article) _then) = __$ArticleCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String summary, String bannerImageUrl, List<String> category, EditProtectionLevel editProtectionLevel, Map<String, dynamic> infoboxData, List<ArticleSection> sections, DateTime createdAt, DateTime updatedAt, int? viewCount
});




}
/// @nodoc
class __$ArticleCopyWithImpl<$Res>
    implements _$ArticleCopyWith<$Res> {
  __$ArticleCopyWithImpl(this._self, this._then);

  final _Article _self;
  final $Res Function(_Article) _then;

/// Create a copy of Article
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? summary = null,Object? bannerImageUrl = null,Object? category = null,Object? editProtectionLevel = null,Object? infoboxData = null,Object? sections = null,Object? createdAt = null,Object? updatedAt = null,Object? viewCount = freezed,}) {
  return _then(_Article(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,bannerImageUrl: null == bannerImageUrl ? _self.bannerImageUrl : bannerImageUrl // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self._category : category // ignore: cast_nullable_to_non_nullable
as List<String>,editProtectionLevel: null == editProtectionLevel ? _self.editProtectionLevel : editProtectionLevel // ignore: cast_nullable_to_non_nullable
as EditProtectionLevel,infoboxData: null == infoboxData ? _self._infoboxData : infoboxData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<ArticleSection>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,viewCount: freezed == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ArticleSection {

 String get id; String get heading; int get level; List<Map<String, dynamic>> get contentDelta;
/// Create a copy of ArticleSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleSectionCopyWith<ArticleSection> get copyWith => _$ArticleSectionCopyWithImpl<ArticleSection>(this as ArticleSection, _$identity);

  /// Serializes this ArticleSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ArticleSection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleSection&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.heading, _this.heading) || other.heading == _this.heading)&&(identical(other.level, _this.level) || other.level == _this.level)&&const DeepCollectionEquality().equals(other.contentDelta, _this.contentDelta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ArticleSection;
  return Object.hash(runtimeType,_this.id,_this.heading,_this.level,const DeepCollectionEquality().hash(_this.contentDelta));
}

@override
String toString() {
  final _this = this as ArticleSection;
  return 'ArticleSection(id: ${_this.id}, heading: ${_this.heading}, level: ${_this.level}, contentDelta: ${_this.contentDelta})';
}


}

/// @nodoc
abstract mixin class $ArticleSectionCopyWith<$Res>  {
  factory $ArticleSectionCopyWith(ArticleSection value, $Res Function(ArticleSection) _then) = _$ArticleSectionCopyWithImpl;
@useResult
$Res call({
 String id, String heading, int level, List<Map<String, dynamic>> contentDelta
});




}
/// @nodoc
class _$ArticleSectionCopyWithImpl<$Res>
    implements $ArticleSectionCopyWith<$Res> {
  _$ArticleSectionCopyWithImpl(this._self, this._then);

  final ArticleSection _self;
  final $Res Function(ArticleSection) _then;

/// Create a copy of ArticleSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? heading = null,Object? level = null,Object? contentDelta = null,}) {
  return _then(ArticleSection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,contentDelta: null == contentDelta ? _self.contentDelta : contentDelta // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}

}


/// Adds pattern-matching-related methods to [ArticleSection].
extension ArticleSectionPatterns on ArticleSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArticleSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArticleSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArticleSection value)  $default,){
final _that = this;
switch (_that) {
case _ArticleSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArticleSection value)?  $default,){
final _that = this;
switch (_that) {
case _ArticleSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String heading,  int level,  List<Map<String, dynamic>> contentDelta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArticleSection() when $default != null:
return $default(_that.id,_that.heading,_that.level,_that.contentDelta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String heading,  int level,  List<Map<String, dynamic>> contentDelta)  $default,) {final _that = this;
switch (_that) {
case _ArticleSection():
return $default(_that.id,_that.heading,_that.level,_that.contentDelta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String heading,  int level,  List<Map<String, dynamic>> contentDelta)?  $default,) {final _that = this;
switch (_that) {
case _ArticleSection() when $default != null:
return $default(_that.id,_that.heading,_that.level,_that.contentDelta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArticleSection implements ArticleSection {
  const _ArticleSection({required this.id, required this.heading, this.level = 1, required  List<Map<String, dynamic>> contentDelta}): _contentDelta = contentDelta;
  factory _ArticleSection.fromJson(Map<String, dynamic> json) => _$ArticleSectionFromJson(json);

@override final  String id;
@override final  String heading;
@override@JsonKey() final  int level;
 final  List<Map<String, dynamic>> _contentDelta;
@override List<Map<String, dynamic>> get contentDelta {
  if (_contentDelta is EqualUnmodifiableListView) return _contentDelta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contentDelta);
}


/// Create a copy of ArticleSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArticleSectionCopyWith<_ArticleSection> get copyWith => __$ArticleSectionCopyWithImpl<_ArticleSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleSectionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArticleSection&&(identical(other.id, id) || other.id == id)&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.level, level) || other.level == level)&&const DeepCollectionEquality().equals(other.contentDelta, _contentDelta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,heading,level,const DeepCollectionEquality().hash(_contentDelta));
}

@override
String toString() {
    return 'ArticleSection(id: $id, heading: $heading, level: $level, contentDelta: $contentDelta)';
}


}

/// @nodoc
abstract mixin class _$ArticleSectionCopyWith<$Res> implements $ArticleSectionCopyWith<$Res> {
  factory _$ArticleSectionCopyWith(_ArticleSection value, $Res Function(_ArticleSection) _then) = __$ArticleSectionCopyWithImpl;
@override @useResult
$Res call({
 String id, String heading, int level, List<Map<String, dynamic>> contentDelta
});




}
/// @nodoc
class __$ArticleSectionCopyWithImpl<$Res>
    implements _$ArticleSectionCopyWith<$Res> {
  __$ArticleSectionCopyWithImpl(this._self, this._then);

  final _ArticleSection _self;
  final $Res Function(_ArticleSection) _then;

/// Create a copy of ArticleSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? heading = null,Object? level = null,Object? contentDelta = null,}) {
  return _then(_ArticleSection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,contentDelta: null == contentDelta ? _self._contentDelta : contentDelta // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}


}

// dart format on
