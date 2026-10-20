import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikipiye/ui/article_detail/viewmodels/article_detail_viewmodel.dart';
import 'package:wikipiye/ui/article_detail/widget/article_detail_content.dart';
import 'package:wikipiye/ui/article_detail/widget/article_save_button.dart';
import 'package:wikipiye/ui/components/async_states.dart';

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
    final article = ref.watch(articleDetailViewmodelProvider(articleId));
    final loaded = article.value;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        actions: [if (loaded != null) ArticleSaveButton(article: loaded)],
      ),
      body: article.when(
        loading: () => const LoadingIndicator(),
        error: (_, _) => MessageState(
          icon: Icons.error_outline,
          message: 'Artikel tidak dapat dimuat.',
          actionLabel: 'Coba lagi',
          onAction: () =>
              ref.invalidate(articleDetailViewmodelProvider(articleId)),
        ),
        data: (data) => ArticleContent(article: data),
      ),
    );
  }
}
