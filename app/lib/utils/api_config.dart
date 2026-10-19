import 'package:flutter/foundation.dart';

class ApiConfig {
  static const String _desktopBaseUrl = 'http://127.0.0.1:8000/api';

  static const String _androidEmulatorBaseUrl = 'http://10.0.2.2:8000/api';

  static String get baseUrl {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return _androidEmulatorBaseUrl;
    }

    return _desktopBaseUrl;
  }
}
