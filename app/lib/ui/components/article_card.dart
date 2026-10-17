import 'package:flutter/material.dart';

import '../../models/article/article.dart';

/// Kartu artikel bergaya Wikipedia: teks di kiri, thumbnail di kanan.
/// [highlight] menebalkan bagian judul yang cocok dengan kata pencarian.
class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.article,
    required this.onTap,
    this.highlight,
    this.trailing,
  });

  final Article article;
  final VoidCallback onTap;
  final String? highlight;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _CardText(article: article, highlight: highlight),
            ),
            const SizedBox(width: 12),
            _Thumbnail(url: article.bannerImageUrl),
            ?trailing,
          ],
        ),
      ),
    );
  }
}

class _CardText extends StatelessWidget {
  const _CardText({required this.article, this.highlight});
  final Article article;
  final String? highlight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HighlightedTitle(title: article.title, query: highlight),
        const SizedBox(height: 4),
        Text(
          article.summary,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            height: 1.35,
            color: Color(0xFF54595D),
          ),
        ),
      ],
    );
  }
}

class _HighlightedTitle extends StatelessWidget {
  const _HighlightedTitle({required this.title, this.query});
  final String title;
  final String? query;

  static const _base = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: Color(0xFF202122),
  );

  @override
  Widget build(BuildContext context) {
    final q = query?.trim().toLowerCase() ?? '';
    final start = q.isEmpty ? -1 : title.toLowerCase().indexOf(q);
    if (start < 0) return Text(title, style: _base);

    final end = start + q.length;
    return Text.rich(
      TextSpan(
        style: _base,
        children: [
          TextSpan(text: title.substring(0, start)),
          TextSpan(
            text: title.substring(start, end),
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFF3366CC),
            ),
          ),
          TextSpan(text: title.substring(end)),
        ],
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 72,
        height: 72,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Container(
            color: const Color(0xFFEAECF0),
            child: const Icon(Icons.image_outlined, color: Color(0xFF72777D)),
          ),
        ),
      ),
    );
  }
}
