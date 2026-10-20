// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequestDTO _$LoginRequestDTOFromJson(Map<String, dynamic> json) =>
    _LoginRequestDTO(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestDTOToJson(_LoginRequestDTO instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

_RegisterRequestDTO _$RegisterRequestDTOFromJson(Map<String, dynamic> json) =>
    _RegisterRequestDTO(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      role: json['role'] as String? ?? 'GUEST',
    );

Map<String, dynamic> _$RegisterRequestDTOToJson(_RegisterRequestDTO instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'role': instance.role,
    };

_AuthResponseDTO _$AuthResponseDTOFromJson(Map<String, dynamic> json) =>
    _AuthResponseDTO(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      user: AuthUserDTO.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseDTOToJson(_AuthResponseDTO instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'user': instance.user,
    };

_AuthUserDTO _$AuthUserDTOFromJson(Map<String, dynamic> json) => _AuthUserDTO(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  email: json['email'] as String,
  firstName: json['first_name'] as String? ?? '',
  lastName: json['last_name'] as String? ?? '',
  isStaff: json['is_staff'] as bool? ?? false,
  role: json['role'] as String? ?? 'GUEST',
);

Map<String, dynamic> _$AuthUserDTOToJson(_AuthUserDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'is_staff': instance.isStaff,
      'role': instance.role,
    };

_RegisterResponseDTO _$RegisterResponseDTOFromJson(Map<String, dynamic> json) =>
    _RegisterResponseDTO(message: json['message'] as String);

Map<String, dynamic> _$RegisterResponseDTOToJson(
  _RegisterResponseDTO instance,
) => <String, dynamic>{'message': instance.message};
