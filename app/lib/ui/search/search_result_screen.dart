import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../article_detail/article_detail_screen.dart';
import '../components/article_card.dart';
import '../components/async_states.dart';
import 'search_notifier.dart';

/// Halaman "Hasil Pencarian" untuk [query].
class SearchResultScreen extends ConsumerWidget {
  const SearchResultScreen({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(searchResultsProvider(query));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Hasil Pencarian',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(28),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                'Kata kunci: "$query"',
                style: const TextStyle(color: Color(0xFF54595D)),
              ),
            ),
          ),
        ),
      ),
      body: results.when(
        loading: () => const LoadingIndicator(),
        error: (e, _) => MessageState(
          icon: Icons.error_outline,
          message: 'Terjadi kesalahan saat mencari.',
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
          return ListView.separated(
            itemCount: articles.length + 1,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, i) {
              if (i == 0) return _ResultCount(count: articles.length);
              final article = articles[i - 1];
              return ArticleCard(
                article: article,
                highlight: query,
                onTap: () => ArticleDetailScreen.open(context, article.id),
              );
            },
          );
        },
      ),
    );
  }
}

class _ResultCount extends StatelessWidget {
  const _ResultCount({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Text(
        '$count artikel ditemukan',
        style: const TextStyle(fontSize: 13, color: Color(0xFF72777D)),
      ),
    );
  }
}
