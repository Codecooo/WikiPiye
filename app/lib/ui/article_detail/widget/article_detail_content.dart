import 'package:flutter/material.dart';

import '../../../models/article/article.dart';
import 'article_footer.dart';
import 'article_header.dart';
import 'article_toc.dart';
import 'wiki_infobox.dart';
import 'wiki_section_view.dart';

/// Badan artikel yang dapat di-scroll: header, infobox, daftar isi, bagian.
class ArticleContent extends StatefulWidget {
  const ArticleContent({super.key, required this.article});

  final Article article;

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  // Satu GlobalKey per section agar Daftar Isi bisa melompat ke bagiannya.
  late final Map<String, GlobalKey> _keys = {
    for (final s in widget.article.sections) s.id: GlobalKey(),
  };

  void _scrollTo(ArticleSection section) {
    final ctx = _keys[section.id]?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArticleHeader(article: article),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WikiInfobox(infoboxData: article.infoboxData),
                ArticleToc(sections: article.sections, onSelected: _scrollTo),
                for (final section in article.sections)
                  KeyedSubtree(
                    key: _keys[section.id],
                    child: WikiSectionView(section: section),
                  ),
                ArticleFooter(article: article),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
