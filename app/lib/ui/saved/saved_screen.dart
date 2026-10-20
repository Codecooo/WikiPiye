import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikipiye/models/article/article.dart';
import 'package:wikipiye/repositories/repository_exceptions.dart';
import 'package:wikipiye/ui/article_detail/article_detail_screen.dart';
import 'package:wikipiye/ui/components/async_states.dart';

import 'saved_article_list.dart';
import 'saved_notifier.dart';

/// Tab "Tersimpan": artikel yang di-bookmark pengguna.
class SavedScreen extends ConsumerWidget {
  const SavedScreen({super.key});

  Future<void> _remove(BuildContext context, WidgetRef ref, Article a) async {
    final messenger = ScaffoldMessenger.of(context);
    final notifier = ref.read(savedArticlesProvider.notifier);
    try {
      await notifier.toggle(a);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('"${a.title}" dihapus'),
            action: SnackBarAction(
              label: 'Urungkan',
              onPressed: () => notifier.toggle(a),
            ),
          ),
        );
    } catch (_) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Gagal menghapus artikel.')),
        );
    }
  }

  Future<void> _refresh(WidgetRef ref) async {
    try {
      await ref.refresh(savedArticlesProvider.future);
    } catch (_) {
      // Galat ditampilkan lewat state provider.
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(savedArticlesProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Tersimpan',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
      ),
      body: saved.when(
        skipLoadingOnReload: true,
        loading: () => const LoadingIndicator(),
        error: (error, _) => error is UnauthorizedException
            ? const MessageState(
                icon: Icons.lock_outline,
                message: 'Masuk untuk melihat artikel yang kamu simpan.',
              )
            : MessageState(
                icon: Icons.error_outline,
                message: 'Gagal memuat artikel tersimpan.',
                actionLabel: 'Coba lagi',
                onAction: () => ref.invalidate(savedArticlesProvider),
              ),
        data: (articles) {
          if (articles.isEmpty) {
            return const MessageState(
              icon: Icons.bookmark_border,
              message: 'Artikel yang kamu simpan akan muncul di sini.',
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refresh(ref),
            child: SavedArticleList(
              articles: articles,
              onOpen: (a) => ArticleDetailScreen.open(context, a.id),
              onRemove: (a) => _remove(context, ref, a),
            ),
          );
        },
      ),
    );
  }
}
