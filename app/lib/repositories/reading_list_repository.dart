import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/reading_list/reading_list.dart';

/// Mengelola daftar bacaan bawaan "Tersimpan".
class ReadingListRepository {
  // TODO: Ganti dengan penyimpanan lokal (offline) + sinkronisasi API.
  ReadingList _saved = ReadingList(
    id: 'list-saved',
    title: 'Tersimpan',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  Future<ReadingList> fetchSavedList() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _saved;
  }

  Future<ReadingList> addArticle(String articleId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (!_saved.articleIds.contains(articleId)) {
      // Artikel terbaru di urutan paling atas.
      _saved = _saved.copyWith(
        articleIds: [articleId, ..._saved.articleIds],
        updatedAt: DateTime.now(),
      );
    }
    return _saved;
  }

  Future<ReadingList> removeArticle(String articleId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _saved = _saved.copyWith(
      articleIds: _saved.articleIds.where((id) => id != articleId).toList(),
      updatedAt: DateTime.now(),
    );
    return _saved;
  }
}

final readingListRepositoryProvider = Provider<ReadingListRepository>((ref) {
  return ReadingListRepository();
});
