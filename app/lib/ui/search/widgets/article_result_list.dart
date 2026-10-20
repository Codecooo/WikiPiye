import 'package:flutter/material.dart';
import 'package:wikipiye/models/article/article.dart';
import 'package:wikipiye/ui/article_detail/article_detail_screen.dart';
import 'package:wikipiye/ui/components/article_card.dart';

/// Daftar [ArticleCard] yang membuka Detail Artikel saat diketuk.
class ArticleResultList extends StatelessWidget {
  const ArticleResultList({
    super.key,
    required this.articles,
    this.highlight,
    this.header,
  });

  final List<Article> articles;
  final String? highlight;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    final offset = header == null ? 0 : 1;
    return ListView.separated(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: articles.length + offset,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, i) {
        if (header != null && i == 0) return header!;
        final article = articles[i - offset];
        return ArticleCard(
          article: article,
          highlight: highlight,
          onTap: () => ArticleDetailScreen.open(context, article.id),
        );
      },
    );
  }
}
