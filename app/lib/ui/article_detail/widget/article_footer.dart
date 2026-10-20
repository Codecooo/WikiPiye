import 'package:flutter/material.dart';

import '../../../models/article/article.dart';
import '../../../utils/date_formatter.dart';

class ArticleFooter extends StatelessWidget {
  const ArticleFooter({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final views = article.viewCount;
    const style = TextStyle(
      fontSize: 13,
      color: Color(0xFF72777D),
      height: 1.5,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'Terakhir diedit ${DateFormatter.toReadableArticleDate(article.updatedAt)}',
            style: style,
          ),
          if (views != null)
            Text(
              'Dibaca ${DateFormatter.toCompactNumber(views)} kali',
              style: style,
            ),
          const Text('Teks tersedia di bawah lisensi CC BY-SA.', style: style),
        ],
      ),
    );
  }
}
