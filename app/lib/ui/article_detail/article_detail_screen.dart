import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/async_states.dart';
import '../saved/saved_notifier.dart';
import 'article_detail_notifier.dart';
import 'widgets/article_content.dart';

/// Halaman "Detail Artikel".
class ArticleDetailScreen extends ConsumerWidget {
  const ArticleDetailScreen({super.key, required this.articleId});

  final String articleId;

  static Future<void> open(BuildContext context, String articleId) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ArticleDetailScreen(articleId: articleId),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final article = ref.watch(articleDetailProvider(articleId));
    final saved = ref.watch(isArticleSavedProvider(articleId));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            tooltip: saved ? 'Hapus dari Tersimpan' : 'Simpan',
            icon: Icon(
              saved ? Icons.bookmark : Icons.bookmark_border,
              color: saved ? const Color(0xFF3366CC) : null,
            ),
            onPressed: () =>
                ref.read(savedArticleIdsProvider.notifier).toggle(articleId),
          ),
        ],
      ),
      body: article.when(
        loading: () => const LoadingIndicator(),
        error: (_, _) => MessageState(
          icon: Icons.error_outline,
          message: 'Artikel tidak dapat dimuat.',
          actionLabel: 'Coba lagi',
          onAction: () => ref.invalidate(articleDetailProvider(articleId)),
        ),
        data: (data) => ArticleContent(article: data),
      ),
    );
  }
}
