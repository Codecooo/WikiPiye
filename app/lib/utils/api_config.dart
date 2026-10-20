/// Class ini berisi dengan konfigurasi API yang digunakan dalam aplikasi. Semua properti yang ada di dalam class ini bersifat static, sehingga dapat diakses tanpa harus membuat instance dari class ini.
class ApiConfig {
  static const String baseUrl = 'http://localhost:8000/api';
  static const int connectionTimeout = 5000; // dalam milidetik
  static const int receiveTimeout = 3000; // dalam milidetik
  static const String tokenKey =
      'auth_token'; // Kunci untuk menyimpan token di Secure Storage
}
