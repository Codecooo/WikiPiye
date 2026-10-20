import 'package:flutter/material.dart';
import 'package:wikipiye/models/article/article.dart';
import 'package:wikipiye/ui/components/article_card.dart';

/// Daftar artikel tersimpan. Geser ke kiri atau ketuk ikon bookmark untuk
/// menghapus.
class SavedArticleList extends StatelessWidget {
  const SavedArticleList({
    super.key,
    required this.articles,
    required this.onOpen,
    required this.onRemove,
  });

  final List<Article> articles;
  final ValueChanged<Article> onOpen;
  final ValueChanged<Article> onRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // Agar tarik-untuk-muat-ulang tetap bisa walau daftarnya pendek.
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: articles.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final article = articles[i];
        return Dismissible(
          key: ValueKey(article.id),
          direction: DismissDirection.endToStart,
          background: const _RemoveBackground(),
          onDismissed: (_) => onRemove(article),
          child: ArticleCard(
            article: article,
            onTap: () => onOpen(article),
            trailing: IconButton(
              icon: const Icon(Icons.bookmark, color: Color(0xFF3366CC)),
              tooltip: 'Hapus dari Tersimpan',
              onPressed: () => onRemove(article),
            ),
          ),
        );
      },
    );
  }
}

class _RemoveBackground extends StatelessWidget {
  const _RemoveBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFDD3333),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(Icons.delete_outline, color: Colors.white),
    );
  }
}
