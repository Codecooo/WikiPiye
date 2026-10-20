import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../models/article/article.dart';

/// Merender satu [ArticleSection]: judul sesuai level + konten Delta (read-only).
class WikiSectionView extends StatefulWidget {
  const WikiSectionView({super.key, required this.section});

  final ArticleSection section;

  @override
  State<WikiSectionView> createState() => _WikiSectionViewState();
}

class _WikiSectionViewState extends State<WikiSectionView> {
  late final QuillController _controller = QuillController(
    document: Document.fromJson(widget.section.contentDelta),
    selection: const TextSelection.collapsed(offset: 0),
    readOnly: true,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final section = widget.section;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (section.heading.isNotEmpty) _SectionHeading(section: section),
        QuillEditor.basic(
          controller: _controller,
          config: const QuillEditorConfig(
            scrollable: false,
            autoFocus: false,
            expands: false,
            showCursor: false,
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.section});

  final ArticleSection section;

  @override
  Widget build(BuildContext context) {
    final level = section.level;
    final style = TextStyle(
      fontFamily: level <= 2 ? 'Georgia' : null,
      fontSize: level == 1 ? 24 : (level == 2 ? 20 : 17),
      fontWeight: level >= 3 ? FontWeight.w600 : FontWeight.w400,
      color: const Color(0xFF202122),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(section.heading, style: style),
        if (level <= 2) const Divider(height: 12, color: Color(0xFFC8CCD1)),
        const SizedBox(height: 4),
      ],
    );
  }
}
