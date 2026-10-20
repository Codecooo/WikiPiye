import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wikipiye/main.dart';
import 'package:wikipiye/models/article/article.dart';
import 'package:wikipiye/repositories/saved_repository.dart';

part 'saved_notifier.g.dart';

/// Artikel yang disimpan (terbaru di atas). Dipakai bersama oleh layar
/// Tersimpan dan tombol bookmark di Detail Artikel.
@Riverpod(keepAlive: true)
class SavedArticles extends _$SavedArticles {
  SavedRepository get _repository => getIt<SavedRepository>();

  @override
  Future<List<Article>> build() => _repository.fetchSavedArticles();

  /// Menyimpan artikel bila belum tersimpan, menghapusnya bila sudah.
  ///
  /// State diubah lebih dulu (optimistic) agar ikon/daftar langsung berubah,
  /// lalu dikembalikan bila request gagal. Galat dilempar ulang supaya UI
  /// bisa menampilkan pesan yang sesuai.
  Future<void> toggle(Article article) async {
    final previous = state;
    final current = previous.value ?? const <Article>[];
    final isSaved = current.any((a) => a.id == article.id);

    state = AsyncData(
      isSaved
          ? current.where((a) => a.id != article.id).toList()
          : [article, ...current],
    );

    try {
      if (isSaved) {
        await _repository.removeArticle(article.id);
      } else {
        await _repository.saveArticle(article.id);
      }
    } catch (_) {
      state = previous;
      rethrow;
    }
  }
}

/// Apakah artikel [articleId] sedang tersimpan.
@riverpod
bool isArticleSaved(Ref ref, String articleId) {
  final saved = ref.watch(savedArticlesProvider).value;
  return saved?.any((a) => a.id == articleId) ?? false;
}
