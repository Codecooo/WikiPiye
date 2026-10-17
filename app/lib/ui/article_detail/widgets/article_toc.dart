import 'package:flutter/material.dart';

import '../../../models/article/article.dart';

/// Daftar isi yang dapat dilipat; ketuk untuk melompat ke bagian.
class ArticleToc extends StatelessWidget {
  const ArticleToc({
    super.key,
    required this.sections,
    required this.onSelected,
  });

  final List<ArticleSection> sections;
  final ValueChanged<ArticleSection> onSelected;

  @override
  Widget build(BuildContext context) {
    final items = sections.where((s) => s.heading.isNotEmpty).toList();
    if (items.isEmpty) return const SizedBox.shrink();

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        initiallyExpanded: true,
        title: const Text(
          'Daftar isi',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        children: [
          for (final s in items)
            InkWell(
              onTap: () => onSelected(s),
              child: Padding(
                // Indentasi (level × 12) + 16 dari panduan; 16 sudah dipenuhi
                // oleh padding halaman, sehingga di sini cukup level × 12.
                padding: EdgeInsets.only(
                  left: s.level * 12.0,
                  top: 8,
                  bottom: 8,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    s.heading,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF3366CC),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
