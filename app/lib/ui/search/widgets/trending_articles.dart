import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikipiye/ui/components/async_states.dart';
import 'package:wikipiye/ui/search/viewmodels/search_viewmodel.dart';

import 'article_result_list.dart';

/// Artikel populer, tampil saat kolom pencarian kosong.
class TrendingArticles extends ConsumerWidget {
  const TrendingArticles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trending = ref.watch(trendingArticlesProvider);
    return trending.when(
      loading: () => const LoadingIndicator(),
      error: (_, _) => MessageState(
        icon: Icons.cloud_off_outlined,
        message: 'Artikel populer tidak dapat dimuat.',
        actionLabel: 'Coba lagi',
        onAction: () => ref.invalidate(trendingArticlesProvider),
      ),
      data: (articles) {
        if (articles.isEmpty) {
          return const MessageState(
            icon: Icons.search,
            message: 'Ketik untuk mencari artikel.',
          );
        }
        return ArticleResultList(
          articles: articles,
          header: const Padding(
            padding: EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Text(
              'Artikel populer',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF54595D),
              ),
            ),
          ),
        );
      },
    );
  }
}
