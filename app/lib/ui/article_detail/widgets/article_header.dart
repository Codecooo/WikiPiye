import 'package:flutter/material.dart';

import '../../../models/article/article.dart';

class ArticleHeader extends StatelessWidget {
  const ArticleHeader({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            article.bannerImageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: const Color(0xFFEAECF0),
              child: const Icon(
                Icons.image_outlined,
                size: 48,
                color: Color(0xFF72777D),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title,
                style: const TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 30,
                  height: 1.2,
                  color: Color(0xFF202122),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                article.summary,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Color(0xFF54595D),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  for (final c in article.category)
                    Chip(
                      label: Text(c),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: const Color(0xFFEAF1FF),
                      side: BorderSide.none,
                      labelStyle: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF3366CC),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
