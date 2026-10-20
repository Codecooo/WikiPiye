import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wikipiye/ui/components/async_states.dart';
import 'package:wikipiye/ui/search/viewmodels/search_viewmodel.dart';

import 'article_result_list.dart';

/// Hasil pencarian untuk [query] (loading, galat, kosong, atau daftar).
class SearchResults extends ConsumerWidget {
  const SearchResults({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(searchResultsProvider(query));
    return results.when(
      loading: () => const LoadingIndicator(),
      error: (_, _) => MessageState(
        icon: Icons.error_outline,
        message: 'Pencarian gagal. Periksa koneksi lalu coba lagi.',
        actionLabel: 'Coba lagi',
        onAction: () => ref.invalidate(searchResultsProvider(query)),
      ),
      data: (articles) {
        if (articles.isEmpty) {
          return MessageState(
            icon: Icons.search_off,
            message: 'Tidak ada artikel yang cocok dengan "$query".',
          );
        }
        return ArticleResultList(articles: articles, highlight: query);
      },
    );
  }
}
