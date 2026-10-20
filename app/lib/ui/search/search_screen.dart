import 'dart:async';

import 'package:flutter/material.dart';

import 'widgets/search_field.dart';
import 'widgets/search_results.dart';
import 'widgets/trending_articles.dart';

/// Tab "Cari". State di sini hanya teks kolom & debounce (state UI lokal);
/// data hasil pencarian diambil oleh provider di `search_viewmodel.dart`.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const _debounceDuration = Duration(milliseconds: 350);

  final _controller = TextEditingController();
  Timer? _debounce;
  String _query = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(_debounceDuration, () => _setQuery(value));
  }

  void _onSubmitted(String value) {
    _debounce?.cancel();
    _setQuery(value);
  }

  void _clear() {
    _debounce?.cancel();
    _controller.clear();
    _setQuery('');
  }

  void _setQuery(String value) {
    final trimmed = value.trim();
    if (!mounted || trimmed == _query) return;
    setState(() => _query = trimmed);
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
          SearchField(
            controller: _controller,
            onChanged: _onChanged,
            onSubmitted: _onSubmitted,
            onClear: _clear,
          ),
          Expanded(
            child: _query.isEmpty
                ? const TrendingArticles()
                : SearchResults(query: _query),
          ),
        ],
      ),
    );
  }
}
