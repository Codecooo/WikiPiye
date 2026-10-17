import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/article/article.dart';
import '../search_notifier.dart';

/// Saran artikel langsung saat pengguna mengetik.
class SearchSuggestions extends ConsumerWidget {
  const SearchSuggestions({
    super.key,
    required this.query,
    required this.onSelected,
    required this.onSeeAll,
  });

  final String query;
  final ValueChanged<Article> onSelected;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestions = ref.watch(searchResultsProvider(query));
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        ListTile(
          leading: const Icon(Icons.search, color: Color(0xFF3366CC)),
          title: Text('Cari "$query"'),
          onTap: onSeeAll,
        ),
        const Divider(height: 1),
        suggestions.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, _) => const ListTile(title: Text('Gagal memuat saran.')),
          data: (articles) => Column(
            children: [
              for (final a in articles.take(5))
                ListTile(
                  leading: const Icon(
                    Icons.article_outlined,
                    color: Color(0xFF54595D),
                  ),
                  title: Text(a.title),
                  subtitle: Text(
                    a.summary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => onSelected(a),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
