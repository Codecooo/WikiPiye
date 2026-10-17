import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/article/article.dart';
import '../../repositories/article_repository.dart';
import '../../repositories/reading_list_repository.dart';

/// Daftar id artikel yang disimpan (terbaru di atas). Dipakai bersama oleh
/// layar Tersimpan dan tombol bookmark di Detail Artikel.
class SavedArticleIds extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    final list = await ref
        .watch(readingListRepositoryProvider)
        .fetchSavedList();
    return list.articleIds;
  }

  Future<void> toggle(String articleId) async {
    final repo = ref.read(readingListRepositoryProvider);
    final current = state.value ?? const <String>[];
    final saved = current.contains(articleId);

    // Optimistic update agar ikon langsung berubah.
    state = AsyncData(
      saved
          ? current.where((id) => id != articleId).toList()
          : [articleId, ...current],
    );
    try {
      final list = saved
          ? await repo.removeArticle(articleId)
          : await repo.addArticle(articleId);
      state = AsyncData(list.articleIds);
    } catch (_) {
      state = AsyncData(current); // rollback
    }
  }
}

final savedArticleIdsProvider =
    AsyncNotifierProvider<SavedArticleIds, List<String>>(SavedArticleIds.new);

/// Apakah artikel [articleId] sedang disimpan.
final isArticleSavedProvider = Provider.autoDispose.family<bool, String>((
  ref,
  articleId,
) {
  final ids = ref.watch(savedArticleIdsProvider).value;
  return ids?.contains(articleId) ?? false;
});

/// Daftar artikel lengkap yang disimpan.
final savedArticlesProvider = FutureProvider.autoDispose<List<Article>>((
  ref,
) async {
  final ids = await ref.watch(savedArticleIdsProvider.future);
  return ref.watch(articleRepositoryProvider).fetchArticlesByIds(ids);
});
