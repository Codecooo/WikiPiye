import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikipiye/models/article/article.dart';
import 'package:wikipiye/repositories/repository_exceptions.dart';
import 'package:wikipiye/ui/saved/saved_notifier.dart';

/// Tombol bookmark di AppBar Detail Artikel.
class ArticleSaveButton extends ConsumerWidget {
  const ArticleSaveButton({super.key, required this.article});

  final Article article;

  Future<void> _toggle(
    BuildContext context,
    WidgetRef ref, {
    required bool wasSaved,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    void show(String message) => messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));

    try {
      await ref.read(savedArticlesProvider.notifier).toggle(article);
      show(wasSaved ? 'Dihapus dari Tersimpan' : 'Artikel disimpan');
    } on UnauthorizedException {
      show('Masuk untuk menyimpan artikel.');
    } catch (_) {
      show('Gagal memperbarui daftar tersimpan.');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(isArticleSavedProvider(article.id));
    return IconButton(
      tooltip: saved ? 'Hapus dari Tersimpan' : 'Simpan',
      icon: Icon(
        saved ? Icons.bookmark : Icons.bookmark_border,
        color: saved ? const Color(0xFF3366CC) : null,
      ),
      onPressed: () => _toggle(context, ref, wasSaved: saved),
    );
  }
}
