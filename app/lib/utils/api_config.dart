import 'package:flutter/foundation.dart';

class ApiConfig {
  // Alamat dasar backend Django untuk Flutter Web di laptop yang sama.
  static const String _defaultBaseUrl = 'http://127.0.0.1:8000/api';

  // Bisa diganti menggunakan --dart-define saat menjalankan aplikasi.
  static const String _configuredBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: _defaultBaseUrl,
  );

  static String get baseUrl => _configuredBaseUrl;

  static Uri communityUrl({int limit = 5}) {
    final base = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;

    return Uri.parse('$base/community/')
        .replace(queryParameters: {'limit': '$limit'});
  }
}
