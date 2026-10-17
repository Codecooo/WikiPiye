import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../search_notifier.dart';
import 'section_title.dart';

class RecentSearchesSection extends ConsumerWidget {
  const RecentSearchesSection({super.key, required this.onSelected});

  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recent = ref.watch(recentSearchesProvider);
    if (recent.isEmpty) return const SizedBox.shrink();

    final notifier = ref.read(recentSearchesProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          'PENCARIAN TERAKHIR',
          action: TextButton(
            onPressed: notifier.clear,
            child: const Text('Hapus semua'),
          ),
        ),
        for (final item in recent)
          ListTile(
            dense: true,
            leading: const Icon(Icons.history, color: Color(0xFF72777D)),
            title: Text(item),
            trailing: IconButton(
              icon: const Icon(Icons.close, size: 20),
              tooltip: 'Hapus',
              onPressed: () => notifier.remove(item),
            ),
            onTap: () => onSelected(item),
          ),
      ],
    );
  }
}
