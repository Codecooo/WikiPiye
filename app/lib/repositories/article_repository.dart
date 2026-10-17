import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/article/article.dart';
import 'article_mock_data.dart';

class ArticleRepository {
  // TODO: Ganti dengan klien Dio/Http (ApiConfig.baseUrl) saat endpoint Django Ninja sudah aktif.

  /// Mencari artikel berdasarkan judul, ringkasan, atau kategori.
  /// Hasil dengan judul yang cocok diurutkan lebih dulu.
  Future<List<Article>> searchArticles(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return [];

    int score(Article a) {
      final title = a.title.toLowerCase();
      if (title == q) return 0;
      if (title.startsWith(q)) return 1;
      if (title.contains(q)) return 2;
      return 3;
    }

    final results = mockArticles.where((a) {
      return a.title.toLowerCase().contains(q) ||
          a.summary.toLowerCase().contains(q) ||
          a.category.any((c) => c.toLowerCase().contains(q));
    }).toList()..sort((a, b) => score(a).compareTo(score(b)));
    return results;
  }

  /// Artikel populer berdasarkan jumlah dilihat (untuk saran di halaman Cari).
  Future<List<Article>> fetchPopularArticles({int limit = 5}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final sorted = [...mockArticles]
      ..sort((a, b) => (b.viewCount ?? 0).compareTo(a.viewCount ?? 0));
    return sorted.take(limit).toList();
  }

  Future<Article> fetchArticleById(String id) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return mockArticles.firstWhere(
      (a) => a.id == id,
      orElse: () => throw Exception('Artikel tidak ditemukan'),
    );
  }

  /// Mengambil banyak artikel sekaligus; urutan mengikuti [ids].
  Future<List<Article>> fetchArticlesByIds(List<String> ids) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final byId = {for (final a in mockArticles) a.id: a};
    return [
      for (final id in ids)
        if (byId[id] != null) byId[id]!,
    ];
  }
}

final articleRepositoryProvider = Provider<ArticleRepository>((ref) {
  return ArticleRepository();
});
