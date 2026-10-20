// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityHistory {

 String get userId; ActivityType get activityType; String get articleId; DateTime get timestamp;
/// Create a copy of ActivityHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityHistoryCopyWith<ActivityHistory> get copyWith => _$ActivityHistoryCopyWithImpl<ActivityHistory>(this as ActivityHistory, _$identity);

  /// Serializes this ActivityHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivityHistory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityHistory&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.activityType, _this.activityType) || other.activityType == _this.activityType)&&(identical(other.articleId, _this.articleId) || other.articleId == _this.articleId)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivityHistory;
  return Object.hash(runtimeType,_this.userId,_this.activityType,_this.articleId,_this.timestamp);
}

@override
String toString() {
  final _this = this as ActivityHistory;
  return 'ActivityHistory(userId: ${_this.userId}, activityType: ${_this.activityType}, articleId: ${_this.articleId}, timestamp: ${_this.timestamp})';
}


}

/// @nodoc
abstract mixin class $ActivityHistoryCopyWith<$Res>  {
  factory $ActivityHistoryCopyWith(ActivityHistory value, $Res Function(ActivityHistory) _then) = _$ActivityHistoryCopyWithImpl;
@useResult
$Res call({
 String userId, ActivityType activityType, String articleId, DateTime timestamp
});




}
/// @nodoc
class _$ActivityHistoryCopyWithImpl<$Res>
    implements $ActivityHistoryCopyWith<$Res> {
  _$ActivityHistoryCopyWithImpl(this._self, this._then);

  final ActivityHistory _self;
  final $Res Function(ActivityHistory) _then;

/// Create a copy of ActivityHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? activityType = null,Object? articleId = null,Object? timestamp = null,}) {
  return _then(ActivityHistory(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,activityType: null == activityType ? _self.activityType : activityType // ignore: cast_nullable_to_non_nullable
as ActivityType,articleId: null == articleId ? _self.articleId : articleId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityHistory].
extension ActivityHistoryPatterns on ActivityHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityHistory value)  $default,){
final _that = this;
switch (_that) {
case _ActivityHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityHistory value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  ActivityType activityType,  String articleId,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityHistory() when $default != null:
return $default(_that.userId,_that.activityType,_that.articleId,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  ActivityType activityType,  String articleId,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _ActivityHistory():
return $default(_that.userId,_that.activityType,_that.articleId,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  ActivityType activityType,  String articleId,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _ActivityHistory() when $default != null:
return $default(_that.userId,_that.activityType,_that.articleId,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityHistory implements ActivityHistory {
  const _ActivityHistory({required this.userId, required this.activityType, required this.articleId, required this.timestamp});
  factory _ActivityHistory.fromJson(Map<String, dynamic> json) => _$ActivityHistoryFromJson(json);

@override final  String userId;
@override final  ActivityType activityType;
@override final  String articleId;
@override final  DateTime timestamp;

/// Create a copy of ActivityHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityHistoryCopyWith<_ActivityHistory> get copyWith => __$ActivityHistoryCopyWithImpl<_ActivityHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityHistory&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.activityType, activityType) || other.activityType == activityType)&&(identical(other.articleId, articleId) || other.articleId == articleId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,activityType,articleId,timestamp);
}

@override
String toString() {
    return 'ActivityHistory(userId: $userId, activityType: $activityType, articleId: $articleId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$ActivityHistoryCopyWith<$Res> implements $ActivityHistoryCopyWith<$Res> {
  factory _$ActivityHistoryCopyWith(_ActivityHistory value, $Res Function(_ActivityHistory) _then) = __$ActivityHistoryCopyWithImpl;
@override @useResult
$Res call({
 String userId, ActivityType activityType, String articleId, DateTime timestamp
});




}
/// @nodoc
class __$ActivityHistoryCopyWithImpl<$Res>
    implements _$ActivityHistoryCopyWith<$Res> {
  __$ActivityHistoryCopyWithImpl(this._self, this._then);

  final _ActivityHistory _self;
  final $Res Function(_ActivityHistory) _then;

/// Create a copy of ActivityHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? activityType = null,Object? articleId = null,Object? timestamp = null,}) {
  return _then(_ActivityHistory(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,activityType: null == activityType ? _self.activityType : activityType // ignore: cast_nullable_to_non_nullable
as ActivityType,articleId: null == articleId ? _self.articleId : articleId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
