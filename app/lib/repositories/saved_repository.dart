import 'package:dio/dio.dart';
import 'package:wikipiye/models/article/article.dart';
import 'package:wikipiye/repositories/repository_exceptions.dart';
import 'package:wikipiye/services/api_service.dart';
import 'package:wikipiye/utils/api_json_mapper.dart';

/// Artikel yang disimpan pengguna (daftar bacaan). Semua endpoint butuh JWT.
class SavedRepository {
  final ApiService _apiService;

  SavedRepository(this._apiService);

  /// Artikel tersimpan milik pengguna, yang terbaru di atas.
  Future<List<Article>> fetchSavedArticles() async {
    try {
      final response = await _apiService.dio.get('/reading-lists/articles');
      return [
        for (final json in response.data as List<dynamic>)
          Article.fromJson(ApiJsonMapper.article(json as Map<String, dynamic>)),
      ];
    } on DioException catch (e) {
      throw _mapError(e, 'Gagal mengambil artikel tersimpan');
    }
  }

  Future<void> saveArticle(String articleId) async {
    try {
      await _apiService.dio.post(
        '/reading-lists/',
        data: {'article_id': int.tryParse(articleId) ?? articleId},
      );
    } on DioException catch (e) {
      throw _mapError(e, 'Gagal menyimpan artikel');
    }
  }

  Future<void> removeArticle(String articleId) async {
    try {
      await _apiService.dio.delete('/reading-lists/article/$articleId');
    } on DioException catch (e) {
      throw _mapError(e, 'Gagal menghapus artikel dari daftar tersimpan');
    }
  }

  Object _mapError(DioException e, String message) {
    if (e.response?.statusCode == 401) return const UnauthorizedException();
    return Exception('$message: ${e.message}');
  }
}
