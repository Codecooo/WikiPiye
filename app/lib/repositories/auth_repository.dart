import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wikipiye/models/dto/dto.dart';
import 'package:wikipiye/services/api_service.dart';
import 'package:wikipiye/utils/api_config.dart';

/// Repository yang bertanggung jawab untuk semua operasi autentikasi:
/// login, register, logout, dan pengecekan sesi aktif.
class AuthRepository {
  final ApiService _apiService;
  final FlutterSecureStorage _storage;

  AuthRepository(this._apiService)
      : _storage = const FlutterSecureStorage();

  // ── Login ──────────────────────────────────────────────────────────────────

  /// Mengirim kredensial ke endpoint POST /auth/login dan menyimpan token
  /// ke Secure Storage. Mengembalikan [AuthUserDTO] jika berhasil.
  Future<AuthUserDTO> login(LoginRequestDTO dto) async {
    try {
      final response = await _apiService.dio.post(
        '/auth/login',
        data: dto.toJson(),
      );

      final authResponse = AuthResponseDTO.fromJson(
        response.data as Map<String, dynamic>,
      );

      // Simpan kedua token ke Secure Storage
      await _storage.write(
        key: ApiConfig.tokenKey,
        value: authResponse.accessToken,
      );
      await _storage.write(
        key: ApiConfig.refreshTokenKey,
        value: authResponse.refreshToken,
      );
      await _storage.write(
        key: 'auth_user_data',
        value: jsonEncode(authResponse.user.toJson()),
      );

      return authResponse.user;
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  // ── Register ───────────────────────────────────────────────────────────────

  /// Mendaftarkan user baru ke endpoint POST /auth/register.
  /// Mengembalikan pesan sukses dari server.
  Future<String> register(RegisterRequestDTO dto) async {
    try {
      final response = await _apiService.dio.post(
        '/auth/register',
        data: dto.toJson(),
      );

      final registerResponse = RegisterResponseDTO.fromJson(
        response.data as Map<String, dynamic>,
      );

      return registerResponse.message;
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  // ── Logout ─────────────────────────────────────────────────────────────────

  /// Menghapus semua token dari Secure Storage (sesi lokal berakhir).
  Future<void> logout() async {
    await _storage.delete(key: ApiConfig.tokenKey);
    await _storage.delete(key: ApiConfig.refreshTokenKey);
    await _storage.delete(key: 'auth_user_data');
  }

  // ── Sesi Aktif ─────────────────────────────────────────────────────────────

  /// Memeriksa apakah ada access token yang tersimpan di Secure Storage.
  Future<bool> hasActiveSession() async {
    final token = await _storage.read(key: ApiConfig.tokenKey);
    return token != null && token.isNotEmpty;
  }

  /// Mengambil data user yang tersimpan di Secure Storage jika ada.
  Future<AuthUserDTO?> getStoredUser() async {
    final token = await _storage.read(key: ApiConfig.tokenKey);
    final userJson = await _storage.read(key: 'auth_user_data');
    if (token != null && token.isNotEmpty && userJson != null) {
      try {
        return AuthUserDTO.fromJson(
          jsonDecode(userJson) as Map<String, dynamic>,
        );
      } catch (_) {}
    }
    return null;
  }

  // ── Helper ─────────────────────────────────────────────────────────────────

  /// Mengekstrak pesan error yang ramah pengguna dari [DioException].
  Exception _mapError(DioException e) {
    final statusCode = e.response?.statusCode;
    final detail = e.response?.data is Map
        ? (e.response!.data as Map)['detail']
        : null;

    if (statusCode == 401) {
      return Exception('Username atau password salah.');
    }
    if (statusCode == 400) {
      return Exception(detail?.toString() ?? 'Data yang dikirim tidak valid.');
    }
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return Exception('Koneksi lambat. Coba lagi.');
    }
    return Exception(detail?.toString() ?? 'Terjadi kesalahan. Coba lagi.');
  }
}
