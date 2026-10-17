import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../article_detail/article_detail_screen.dart';
import '../components/async_states.dart';
import 'saved_notifier.dart';
import 'widgets/saved_article_list.dart';

/// Halaman "Tersimpan": artikel yang di-bookmark pengguna.
class SavedScreen extends ConsumerWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(savedArticlesProvider);
    // Saring dengan id terkini agar item yang baru dihapus langsung hilang
    // (wajib untuk Dismissible) tanpa menunggu pemuatan ulang.
    final ids = ref.watch(savedArticleIdsProvider).value ?? const <String>[];
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
        error: (_, _) => MessageState(
          icon: Icons.error_outline,
          message: 'Gagal memuat artikel tersimpan.',
          actionLabel: 'Coba lagi',
          onAction: () => ref.invalidate(savedArticlesProvider),
        ),
        data: (loaded) {
          final articles = loaded.where((a) => ids.contains(a.id)).toList();
          if (articles.isEmpty) {
            return const MessageState(
              icon: Icons.bookmark_border,
              message: 'Artikel yang kamu simpan akan muncul di sini.',
            );
          }
          return SavedArticleList(
            articles: articles,
            onOpen: (a) => ArticleDetailScreen.open(context, a.id),
            onRemove: (a) =>
                ref.read(savedArticleIdsProvider.notifier).toggle(a.id),
          );
        },
      ),
    );
  }
}
