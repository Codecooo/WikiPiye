import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/article/article.dart';
import '../../components/article_card.dart';
import '../search_notifier.dart';
import 'section_title.dart';

class PopularArticlesSection extends ConsumerWidget {
  const PopularArticlesSection({super.key, required this.onSelected});

  final ValueChanged<Article> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popular = ref.watch(popularArticlesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('ARTIKEL POPULER'),
        popular.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (_, _) => const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Gagal memuat artikel populer.'),
          ),
          data: (articles) => Column(
            children: [
              for (final a in articles)
                ArticleCard(article: a, onTap: () => onSelected(a)),
            ],
          ),
        ),
      ],
    );
  }
}
