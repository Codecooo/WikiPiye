import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod/riverpod.dart';

import '../utils/api_config.dart';

class ApiService {
  final Dio dio;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  ApiService()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          connectTimeout: Duration(milliseconds: ApiConfig.connectionTimeout),
          receiveTimeout: Duration(milliseconds: ApiConfig.receiveTimeout),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      ) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Sisipkan Bearer Token jika tersimpan di Secure Storage
          final token = await storage.read(key: ApiConfig.tokenKey);
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) {
          // Tangani global error (misal: 401 Unauthorized)
          if (error.response?.statusCode == 401) {
            // Logic token expired / logout
          }
          return handler.next(error);
        },
      ),
    );
  }
}

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(); // atau inisialisasi Dio / konfigurasi base URL di sini
});
