import 'package:freezed_annotation/freezed_annotation.dart';

part 'dto.freezed.dart';
part 'dto.g.dart';

// ── Auth DTOs ─────────────────────────────────────────────────────────────────

/// Payload request untuk endpoint POST /auth/login
@freezed
abstract class LoginRequestDTO with _$LoginRequestDTO {
  const factory LoginRequestDTO({
    required String username,
    required String password,
  }) = _LoginRequestDTO;

  factory LoginRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDTOFromJson(json);
}

/// Payload request untuk endpoint POST /auth/register
@freezed
abstract class RegisterRequestDTO with _$RegisterRequestDTO {
  const factory RegisterRequestDTO({
    required String username,
    required String email,
    required String password,
    @JsonKey(name: 'first_name') @Default('') String firstName,
    @JsonKey(name: 'last_name') @Default('') String lastName,
    @Default('GUEST') String role,
  }) = _RegisterRequestDTO;

  factory RegisterRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestDTOFromJson(json);
}

/// Respons dari endpoint POST /auth/login (berisi token & data user)
@freezed
abstract class AuthResponseDTO with _$AuthResponseDTO {
  const factory AuthResponseDTO({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    required AuthUserDTO user,
  }) = _AuthResponseDTO;

  factory AuthResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDTOFromJson(json);
}

/// Data user yang dikembalikan setelah login berhasil
@freezed
abstract class AuthUserDTO with _$AuthUserDTO {
  const factory AuthUserDTO({
    required int id,
    required String username,
    required String email,
    @JsonKey(name: 'first_name') @Default('') String firstName,
    @JsonKey(name: 'last_name') @Default('') String lastName,
    @JsonKey(name: 'is_staff') @Default(false) bool isStaff,
    @Default('GUEST') String role,
  }) = _AuthUserDTO;

  factory AuthUserDTO.fromJson(Map<String, dynamic> json) =>
      _$AuthUserDTOFromJson(json);
}

/// Respons dari endpoint POST /auth/register
@freezed
abstract class RegisterResponseDTO with _$RegisterResponseDTO {
  const factory RegisterResponseDTO({
    required String message,
  }) = _RegisterResponseDTO;

  factory RegisterResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseDTOFromJson(json);
}
