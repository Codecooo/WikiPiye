import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wikipiye/main.dart';
import 'package:wikipiye/models/article/article.dart';
import 'package:wikipiye/repositories/article_repository.dart';

part 'search_viewmodel.g.dart';

/// Hasil pencarian untuk [query]. Request yang masih berjalan dibatalkan
/// otomatis saat query berganti (provider lama di-dispose).
@riverpod
Future<List<Article>> searchResults(Ref ref, String query) {
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);
  return getIt<ArticleRepository>().searchArticles(
    query,
    cancelToken: cancelToken,
  );
}

/// Artikel populer, ditampilkan saat kolom pencarian masih kosong.
@riverpod
Future<List<Article>> trendingArticles(Ref ref) {
  return getIt<ArticleRepository>().fetchTrendingArticles();
}
