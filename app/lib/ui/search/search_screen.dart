import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../article_detail/article_detail_screen.dart';
import 'search_notifier.dart';
import 'search_result_screen.dart';
import 'widgets/popular_articles_section.dart';
import 'widgets/recent_searches_section.dart';
import 'widgets/search_input.dart';
import 'widgets/search_suggestions.dart';

/// Halaman "Cari": kolom pencarian, saran langsung, riwayat, dan artikel populer.
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit(String value) {
    final q = value.trim();
    if (q.isEmpty) return;
    ref.read(recentSearchesProvider.notifier).add(q);
    FocusScope.of(context).unfocus();
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => SearchResultScreen(query: q)),
    );
  }

  void _useQuery(String value) {
    _controller.text = value;
    _controller.selection = TextSelection.collapsed(offset: value.length);
    setState(() => _query = value);
    _submit(value);
  }

  void _clear() {
    _controller.clear();
    setState(() => _query = '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Cari',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SearchInput(
            controller: _controller,
            showClear: _query.isNotEmpty,
            onChanged: (v) => setState(() => _query = v),
            onSubmitted: _submit,
            onClear: _clear,
          ),
          Expanded(
            child: _query.trim().isEmpty
                ? ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      RecentSearchesSection(onSelected: _useQuery),
                      PopularArticlesSection(
                        onSelected: (article) =>
                            ArticleDetailScreen.open(context, article.id),
                      ),
                    ],
                  )
                : SearchSuggestions(
                    query: _query.trim(),
                    onSelected: (article) {
                      ref
                          .read(recentSearchesProvider.notifier)
                          .add(article.title);
                      ArticleDetailScreen.open(context, article.id);
                    },
                    onSeeAll: () => _submit(_query),
                  ),
          ),
        ],
      ),
    );
  }
}
