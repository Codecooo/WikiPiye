import 'package:dio/dio.dart';
import 'package:wikipiye/models/article/article.dart';
import 'package:wikipiye/services/api_service.dart';
import 'package:wikipiye/utils/api_json_mapper.dart';

class ArticleRepository {
  final ApiService _apiService;

  ArticleRepository(this._apiService);

  /// Mencari artikel berdasarkan judul. Urutan (cocok persis, diawali, lalu
  /// mengandung) sudah ditentukan oleh backend.
  Future<List<Article>> searchArticles(
    String query, {
    CancelToken? cancelToken,
  }) async {
    final q = query.trim();
    if (q.isEmpty) return const [];

    try {
      final response = await _apiService.dio.get(
        '/articles/search',
        queryParameters: {'query': q},
        cancelToken: cancelToken,
      );
      return _parseList(response.data);
    } on DioException catch (e) {
      throw Exception('Gagal mencari artikel: ${e.message}');
    }
  }

  /// Artikel terpopuler berdasarkan jumlah baca.
  Future<List<Article>> fetchTrendingArticles() async {
    try {
      final response = await _apiService.dio.get('/articles/trending');
      return _parseList(response.data);
    } on DioException catch (e) {
      throw Exception('Gagal mengambil artikel populer: ${e.message}');
    }
  }

  /// Mengambil artikel lengkap (beserta sections) berdasarkan ID.
  Future<Article> fetchArticleById(String id) async {
    try {
      final response = await _apiService.dio.get('/articles/$id');
      return Article.fromJson(
        ApiJsonMapper.article(response.data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('Artikel tidak ditemukan.');
      }
      throw Exception('Gagal mengambil artikel: ${e.message}');
    }
  }

  static List<Article> _parseList(dynamic data) {
    return [
      for (final json in data as List<dynamic>)
        Article.fromJson(ApiJsonMapper.article(json as Map<String, dynamic>)),
    ];
  }
}
