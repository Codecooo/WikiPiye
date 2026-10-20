// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginRequestDTO {

 String get username; String get password;
/// Create a copy of LoginRequestDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginRequestDTOCopyWith<LoginRequestDTO> get copyWith => _$LoginRequestDTOCopyWithImpl<LoginRequestDTO>(this as LoginRequestDTO, _$identity);

  /// Serializes this LoginRequestDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LoginRequestDTO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginRequestDTO&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.password, _this.password) || other.password == _this.password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LoginRequestDTO;
  return Object.hash(runtimeType,_this.username,_this.password);
}

@override
String toString() {
  final _this = this as LoginRequestDTO;
  return 'LoginRequestDTO(username: ${_this.username}, password: ${_this.password})';
}


}

/// @nodoc
abstract mixin class $LoginRequestDTOCopyWith<$Res>  {
  factory $LoginRequestDTOCopyWith(LoginRequestDTO value, $Res Function(LoginRequestDTO) _then) = _$LoginRequestDTOCopyWithImpl;
@useResult
$Res call({
 String username, String password
});




}
/// @nodoc
class _$LoginRequestDTOCopyWithImpl<$Res>
    implements $LoginRequestDTOCopyWith<$Res> {
  _$LoginRequestDTOCopyWithImpl(this._self, this._then);

  final LoginRequestDTO _self;
  final $Res Function(LoginRequestDTO) _then;

/// Create a copy of LoginRequestDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? password = null,}) {
  return _then(LoginRequestDTO(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginRequestDTO].
extension LoginRequestDTOPatterns on LoginRequestDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginRequestDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginRequestDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginRequestDTO value)  $default,){
final _that = this;
switch (_that) {
case _LoginRequestDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginRequestDTO value)?  $default,){
final _that = this;
switch (_that) {
case _LoginRequestDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginRequestDTO() when $default != null:
return $default(_that.username,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username,  String password)  $default,) {final _that = this;
switch (_that) {
case _LoginRequestDTO():
return $default(_that.username,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username,  String password)?  $default,) {final _that = this;
switch (_that) {
case _LoginRequestDTO() when $default != null:
return $default(_that.username,_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginRequestDTO implements LoginRequestDTO {
  const _LoginRequestDTO({required this.username, required this.password});
  factory _LoginRequestDTO.fromJson(Map<String, dynamic> json) => _$LoginRequestDTOFromJson(json);

@override final  String username;
@override final  String password;

/// Create a copy of LoginRequestDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginRequestDTOCopyWith<_LoginRequestDTO> get copyWith => __$LoginRequestDTOCopyWithImpl<_LoginRequestDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginRequestDTOToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginRequestDTO&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,username,password);
}

@override
String toString() {
    return 'LoginRequestDTO(username: $username, password: $password)';
}


}

/// @nodoc
abstract mixin class _$LoginRequestDTOCopyWith<$Res> implements $LoginRequestDTOCopyWith<$Res> {
  factory _$LoginRequestDTOCopyWith(_LoginRequestDTO value, $Res Function(_LoginRequestDTO) _then) = __$LoginRequestDTOCopyWithImpl;
@override @useResult
$Res call({
 String username, String password
});




}
/// @nodoc
class __$LoginRequestDTOCopyWithImpl<$Res>
    implements _$LoginRequestDTOCopyWith<$Res> {
  __$LoginRequestDTOCopyWithImpl(this._self, this._then);

  final _LoginRequestDTO _self;
  final $Res Function(_LoginRequestDTO) _then;

/// Create a copy of LoginRequestDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? password = null,}) {
  return _then(_LoginRequestDTO(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RegisterRequestDTO {

 String get username; String get email; String get password;@JsonKey(name: 'first_name') String get firstName;@JsonKey(name: 'last_name') String get lastName; String get role;
/// Create a copy of RegisterRequestDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterRequestDTOCopyWith<RegisterRequestDTO> get copyWith => _$RegisterRequestDTOCopyWithImpl<RegisterRequestDTO>(this as RegisterRequestDTO, _$identity);

  /// Serializes this RegisterRequestDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RegisterRequestDTO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterRequestDTO&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.role, _this.role) || other.role == _this.role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RegisterRequestDTO;
  return Object.hash(runtimeType,_this.username,_this.email,_this.password,_this.firstName,_this.lastName,_this.role);
}

@override
String toString() {
  final _this = this as RegisterRequestDTO;
  return 'RegisterRequestDTO(username: ${_this.username}, email: ${_this.email}, password: ${_this.password}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, role: ${_this.role})';
}


}

/// @nodoc
abstract mixin class $RegisterRequestDTOCopyWith<$Res>  {
  factory $RegisterRequestDTOCopyWith(RegisterRequestDTO value, $Res Function(RegisterRequestDTO) _then) = _$RegisterRequestDTOCopyWithImpl;
@useResult
$Res call({
 String username, String email, String password,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName, String role
});




}
/// @nodoc
class _$RegisterRequestDTOCopyWithImpl<$Res>
    implements $RegisterRequestDTOCopyWith<$Res> {
  _$RegisterRequestDTOCopyWithImpl(this._self, this._then);

  final RegisterRequestDTO _self;
  final $Res Function(RegisterRequestDTO) _then;

/// Create a copy of RegisterRequestDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? email = null,Object? password = null,Object? firstName = null,Object? lastName = null,Object? role = null,}) {
  return _then(RegisterRequestDTO(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterRequestDTO].
extension RegisterRequestDTOPatterns on RegisterRequestDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterRequestDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterRequestDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterRequestDTO value)  $default,){
final _that = this;
switch (_that) {
case _RegisterRequestDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterRequestDTO value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterRequestDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username,  String email,  String password, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName,  String role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterRequestDTO() when $default != null:
return $default(_that.username,_that.email,_that.password,_that.firstName,_that.lastName,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username,  String email,  String password, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName,  String role)  $default,) {final _that = this;
switch (_that) {
case _RegisterRequestDTO():
return $default(_that.username,_that.email,_that.password,_that.firstName,_that.lastName,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username,  String email,  String password, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName,  String role)?  $default,) {final _that = this;
switch (_that) {
case _RegisterRequestDTO() when $default != null:
return $default(_that.username,_that.email,_that.password,_that.firstName,_that.lastName,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterRequestDTO implements RegisterRequestDTO {
  const _RegisterRequestDTO({required this.username, required this.email, required this.password, @JsonKey(name: 'first_name') this.firstName = '', @JsonKey(name: 'last_name') this.lastName = '', this.role = 'GUEST'});
  factory _RegisterRequestDTO.fromJson(Map<String, dynamic> json) => _$RegisterRequestDTOFromJson(json);

@override final  String username;
@override final  String email;
@override final  String password;
@override@JsonKey(name: 'first_name') final  String firstName;
@override@JsonKey(name: 'last_name') final  String lastName;
@override@JsonKey() final  String role;

/// Create a copy of RegisterRequestDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterRequestDTOCopyWith<_RegisterRequestDTO> get copyWith => __$RegisterRequestDTOCopyWithImpl<_RegisterRequestDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterRequestDTOToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterRequestDTO&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,username,email,password,firstName,lastName,role);
}

@override
String toString() {
    return 'RegisterRequestDTO(username: $username, email: $email, password: $password, firstName: $firstName, lastName: $lastName, role: $role)';
}


}

/// @nodoc
abstract mixin class _$RegisterRequestDTOCopyWith<$Res> implements $RegisterRequestDTOCopyWith<$Res> {
  factory _$RegisterRequestDTOCopyWith(_RegisterRequestDTO value, $Res Function(_RegisterRequestDTO) _then) = __$RegisterRequestDTOCopyWithImpl;
@override @useResult
$Res call({
 String username, String email, String password,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName, String role
});




}
/// @nodoc
class __$RegisterRequestDTOCopyWithImpl<$Res>
    implements _$RegisterRequestDTOCopyWith<$Res> {
  __$RegisterRequestDTOCopyWithImpl(this._self, this._then);

  final _RegisterRequestDTO _self;
  final $Res Function(_RegisterRequestDTO) _then;

/// Create a copy of RegisterRequestDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? email = null,Object? password = null,Object? firstName = null,Object? lastName = null,Object? role = null,}) {
  return _then(_RegisterRequestDTO(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AuthResponseDTO {

@JsonKey(name: 'access_token') String get accessToken;@JsonKey(name: 'refresh_token') String get refreshToken; AuthUserDTO get user;
/// Create a copy of AuthResponseDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthResponseDTOCopyWith<AuthResponseDTO> get copyWith => _$AuthResponseDTOCopyWithImpl<AuthResponseDTO>(this as AuthResponseDTO, _$identity);

  /// Serializes this AuthResponseDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AuthResponseDTO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthResponseDTO&&(identical(other.accessToken, _this.accessToken) || other.accessToken == _this.accessToken)&&(identical(other.refreshToken, _this.refreshToken) || other.refreshToken == _this.refreshToken)&&(identical(other.user, _this.user) || other.user == _this.user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AuthResponseDTO;
  return Object.hash(runtimeType,_this.accessToken,_this.refreshToken,_this.user);
}

@override
String toString() {
  final _this = this as AuthResponseDTO;
  return 'AuthResponseDTO(accessToken: ${_this.accessToken}, refreshToken: ${_this.refreshToken}, user: ${_this.user})';
}


}

/// @nodoc
abstract mixin class $AuthResponseDTOCopyWith<$Res>  {
  factory $AuthResponseDTOCopyWith(AuthResponseDTO value, $Res Function(AuthResponseDTO) _then) = _$AuthResponseDTOCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'access_token') String accessToken,@JsonKey(name: 'refresh_token') String refreshToken, AuthUserDTO user
});


$AuthUserDTOCopyWith<$Res> get user;

}
/// @nodoc
class _$AuthResponseDTOCopyWithImpl<$Res>
    implements $AuthResponseDTOCopyWith<$Res> {
  _$AuthResponseDTOCopyWithImpl(this._self, this._then);

  final AuthResponseDTO _self;
  final $Res Function(AuthResponseDTO) _then;

/// Create a copy of AuthResponseDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? refreshToken = null,Object? user = null,}) {
  return _then(AuthResponseDTO(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUserDTO,
  ));
}
/// Create a copy of AuthResponseDTO
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserDTOCopyWith<$Res> get user {
  
  return $AuthUserDTOCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthResponseDTO].
extension AuthResponseDTOPatterns on AuthResponseDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthResponseDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthResponseDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthResponseDTO value)  $default,){
final _that = this;
switch (_that) {
case _AuthResponseDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthResponseDTO value)?  $default,){
final _that = this;
switch (_that) {
case _AuthResponseDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken,  AuthUserDTO user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthResponseDTO() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken,  AuthUserDTO user)  $default,) {final _that = this;
switch (_that) {
case _AuthResponseDTO():
return $default(_that.accessToken,_that.refreshToken,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken,  AuthUserDTO user)?  $default,) {final _that = this;
switch (_that) {
case _AuthResponseDTO() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthResponseDTO implements AuthResponseDTO {
  const _AuthResponseDTO({@JsonKey(name: 'access_token') required this.accessToken, @JsonKey(name: 'refresh_token') required this.refreshToken, required this.user});
  factory _AuthResponseDTO.fromJson(Map<String, dynamic> json) => _$AuthResponseDTOFromJson(json);

@override@JsonKey(name: 'access_token') final  String accessToken;
@override@JsonKey(name: 'refresh_token') final  String refreshToken;
@override final  AuthUserDTO user;

/// Create a copy of AuthResponseDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthResponseDTOCopyWith<_AuthResponseDTO> get copyWith => __$AuthResponseDTOCopyWithImpl<_AuthResponseDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthResponseDTOToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthResponseDTO&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,accessToken,refreshToken,user);
}

@override
String toString() {
    return 'AuthResponseDTO(accessToken: $accessToken, refreshToken: $refreshToken, user: $user)';
}


}

/// @nodoc
abstract mixin class _$AuthResponseDTOCopyWith<$Res> implements $AuthResponseDTOCopyWith<$Res> {
  factory _$AuthResponseDTOCopyWith(_AuthResponseDTO value, $Res Function(_AuthResponseDTO) _then) = __$AuthResponseDTOCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'access_token') String accessToken,@JsonKey(name: 'refresh_token') String refreshToken, AuthUserDTO user
});


@override $AuthUserDTOCopyWith<$Res> get user;

}
/// @nodoc
class __$AuthResponseDTOCopyWithImpl<$Res>
    implements _$AuthResponseDTOCopyWith<$Res> {
  __$AuthResponseDTOCopyWithImpl(this._self, this._then);

  final _AuthResponseDTO _self;
  final $Res Function(_AuthResponseDTO) _then;

/// Create a copy of AuthResponseDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,Object? user = null,}) {
  return _then(_AuthResponseDTO(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUserDTO,
  ));
}

/// Create a copy of AuthResponseDTO
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserDTOCopyWith<$Res> get user {
  
  return $AuthUserDTOCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$AuthUserDTO {

 int get id; String get username; String get email;@JsonKey(name: 'first_name') String get firstName;@JsonKey(name: 'last_name') String get lastName;@JsonKey(name: 'is_staff') bool get isStaff; String get role;
/// Create a copy of AuthUserDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthUserDTOCopyWith<AuthUserDTO> get copyWith => _$AuthUserDTOCopyWithImpl<AuthUserDTO>(this as AuthUserDTO, _$identity);

  /// Serializes this AuthUserDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AuthUserDTO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUserDTO&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.isStaff, _this.isStaff) || other.isStaff == _this.isStaff)&&(identical(other.role, _this.role) || other.role == _this.role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AuthUserDTO;
  return Object.hash(runtimeType,_this.id,_this.username,_this.email,_this.firstName,_this.lastName,_this.isStaff,_this.role);
}

@override
String toString() {
  final _this = this as AuthUserDTO;
  return 'AuthUserDTO(id: ${_this.id}, username: ${_this.username}, email: ${_this.email}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, isStaff: ${_this.isStaff}, role: ${_this.role})';
}


}

/// @nodoc
abstract mixin class $AuthUserDTOCopyWith<$Res>  {
  factory $AuthUserDTOCopyWith(AuthUserDTO value, $Res Function(AuthUserDTO) _then) = _$AuthUserDTOCopyWithImpl;
@useResult
$Res call({
 int id, String username, String email,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'is_staff') bool isStaff, String role
});




}
/// @nodoc
class _$AuthUserDTOCopyWithImpl<$Res>
    implements $AuthUserDTOCopyWith<$Res> {
  _$AuthUserDTOCopyWithImpl(this._self, this._then);

  final AuthUserDTO _self;
  final $Res Function(AuthUserDTO) _then;

/// Create a copy of AuthUserDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? isStaff = null,Object? role = null,}) {
  return _then(AuthUserDTO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,isStaff: null == isStaff ? _self.isStaff : isStaff // ignore: cast_nullable_to_non_nullable
as bool,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthUserDTO].
extension AuthUserDTOPatterns on AuthUserDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthUserDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthUserDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthUserDTO value)  $default,){
final _that = this;
switch (_that) {
case _AuthUserDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthUserDTO value)?  $default,){
final _that = this;
switch (_that) {
case _AuthUserDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String username,  String email, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'is_staff')  bool isStaff,  String role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthUserDTO() when $default != null:
return $default(_that.id,_that.username,_that.email,_that.firstName,_that.lastName,_that.isStaff,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String username,  String email, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'is_staff')  bool isStaff,  String role)  $default,) {final _that = this;
switch (_that) {
case _AuthUserDTO():
return $default(_that.id,_that.username,_that.email,_that.firstName,_that.lastName,_that.isStaff,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String username,  String email, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName, @JsonKey(name: 'is_staff')  bool isStaff,  String role)?  $default,) {final _that = this;
switch (_that) {
case _AuthUserDTO() when $default != null:
return $default(_that.id,_that.username,_that.email,_that.firstName,_that.lastName,_that.isStaff,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthUserDTO implements AuthUserDTO {
  const _AuthUserDTO({required this.id, required this.username, required this.email, @JsonKey(name: 'first_name') this.firstName = '', @JsonKey(name: 'last_name') this.lastName = '', @JsonKey(name: 'is_staff') this.isStaff = false, this.role = 'GUEST'});
  factory _AuthUserDTO.fromJson(Map<String, dynamic> json) => _$AuthUserDTOFromJson(json);

@override final  int id;
@override final  String username;
@override final  String email;
@override@JsonKey(name: 'first_name') final  String firstName;
@override@JsonKey(name: 'last_name') final  String lastName;
@override@JsonKey(name: 'is_staff') final  bool isStaff;
@override@JsonKey() final  String role;

/// Create a copy of AuthUserDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthUserDTOCopyWith<_AuthUserDTO> get copyWith => __$AuthUserDTOCopyWithImpl<_AuthUserDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthUserDTOToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthUserDTO&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.isStaff, isStaff) || other.isStaff == isStaff)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,username,email,firstName,lastName,isStaff,role);
}

@override
String toString() {
    return 'AuthUserDTO(id: $id, username: $username, email: $email, firstName: $firstName, lastName: $lastName, isStaff: $isStaff, role: $role)';
}


}

/// @nodoc
abstract mixin class _$AuthUserDTOCopyWith<$Res> implements $AuthUserDTOCopyWith<$Res> {
  factory _$AuthUserDTOCopyWith(_AuthUserDTO value, $Res Function(_AuthUserDTO) _then) = __$AuthUserDTOCopyWithImpl;
@override @useResult
$Res call({
 int id, String username, String email,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName,@JsonKey(name: 'is_staff') bool isStaff, String role
});




}
/// @nodoc
class __$AuthUserDTOCopyWithImpl<$Res>
    implements _$AuthUserDTOCopyWith<$Res> {
  __$AuthUserDTOCopyWithImpl(this._self, this._then);

  final _AuthUserDTO _self;
  final $Res Function(_AuthUserDTO) _then;

/// Create a copy of AuthUserDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? isStaff = null,Object? role = null,}) {
  return _then(_AuthUserDTO(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,isStaff: null == isStaff ? _self.isStaff : isStaff // ignore: cast_nullable_to_non_nullable
as bool,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RegisterResponseDTO {

 String get message;
/// Create a copy of RegisterResponseDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterResponseDTOCopyWith<RegisterResponseDTO> get copyWith => _$RegisterResponseDTOCopyWithImpl<RegisterResponseDTO>(this as RegisterResponseDTO, _$identity);

  /// Serializes this RegisterResponseDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RegisterResponseDTO;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterResponseDTO&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RegisterResponseDTO;
  return Object.hash(runtimeType,_this.message);
}

@override
String toString() {
  final _this = this as RegisterResponseDTO;
  return 'RegisterResponseDTO(message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $RegisterResponseDTOCopyWith<$Res>  {
  factory $RegisterResponseDTOCopyWith(RegisterResponseDTO value, $Res Function(RegisterResponseDTO) _then) = _$RegisterResponseDTOCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RegisterResponseDTOCopyWithImpl<$Res>
    implements $RegisterResponseDTOCopyWith<$Res> {
  _$RegisterResponseDTOCopyWithImpl(this._self, this._then);

  final RegisterResponseDTO _self;
  final $Res Function(RegisterResponseDTO) _then;

/// Create a copy of RegisterResponseDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,}) {
  return _then(RegisterResponseDTO(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterResponseDTO].
extension RegisterResponseDTOPatterns on RegisterResponseDTO {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterResponseDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterResponseDTO() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterResponseDTO value)  $default,){
final _that = this;
switch (_that) {
case _RegisterResponseDTO():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterResponseDTO value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterResponseDTO() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterResponseDTO() when $default != null:
return $default(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message)  $default,) {final _that = this;
switch (_that) {
case _RegisterResponseDTO():
return $default(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message)?  $default,) {final _that = this;
switch (_that) {
case _RegisterResponseDTO() when $default != null:
return $default(_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterResponseDTO implements RegisterResponseDTO {
  const _RegisterResponseDTO({required this.message});
  factory _RegisterResponseDTO.fromJson(Map<String, dynamic> json) => _$RegisterResponseDTOFromJson(json);

@override final  String message;

/// Create a copy of RegisterResponseDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterResponseDTOCopyWith<_RegisterResponseDTO> get copyWith => __$RegisterResponseDTOCopyWithImpl<_RegisterResponseDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterResponseDTOToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterResponseDTO&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'RegisterResponseDTO(message: $message)';
}


}

/// @nodoc
abstract mixin class _$RegisterResponseDTOCopyWith<$Res> implements $RegisterResponseDTOCopyWith<$Res> {
  factory _$RegisterResponseDTOCopyWith(_RegisterResponseDTO value, $Res Function(_RegisterResponseDTO) _then) = __$RegisterResponseDTOCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class __$RegisterResponseDTOCopyWithImpl<$Res>
    implements _$RegisterResponseDTOCopyWith<$Res> {
  __$RegisterResponseDTOCopyWithImpl(this._self, this._then);

  final _RegisterResponseDTO _self;
  final $Res Function(_RegisterResponseDTO) _then;

/// Create a copy of RegisterResponseDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_RegisterResponseDTO(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
