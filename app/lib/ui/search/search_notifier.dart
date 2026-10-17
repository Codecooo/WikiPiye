import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/article/article.dart';
import '../../repositories/article_repository.dart';

/// Hasil pencarian untuk sebuah query. Dibatalkan otomatis (debounce 300 ms)
/// bila query berganti sebelum selesai.
final searchResultsProvider = FutureProvider.autoDispose
    .family<List<Article>, String>((ref, query) async {
      var cancelled = false;
      ref.onDispose(() => cancelled = true);

      await Future.delayed(const Duration(milliseconds: 300));
      if (cancelled) return const <Article>[];

      return ref.read(articleRepositoryProvider).searchArticles(query);
    });

final popularArticlesProvider = FutureProvider.autoDispose<List<Article>>((
  ref,
) {
  return ref.watch(articleRepositoryProvider).fetchPopularArticles();
});

/// Riwayat pencarian terbaru (terbaru di atas, maksimal 8).
class RecentSearches extends Notifier<List<String>> {
  static const _maxItems = 8;

  @override
  List<String> build() => const [];

  void add(String query) {
    final q = query.trim();
    if (q.isEmpty) return;
    final others = state.where((e) => e.toLowerCase() != q.toLowerCase());
    state = [q, ...others].take(_maxItems).toList();
  }

  void remove(String query) {
    state = state.where((e) => e != query).toList();
  }

  void clear() => state = const [];
}

final recentSearchesProvider = NotifierProvider<RecentSearches, List<String>>(
  RecentSearches.new,
);
