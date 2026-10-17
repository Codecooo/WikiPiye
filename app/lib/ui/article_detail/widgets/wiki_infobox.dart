import 'package:flutter/material.dart';

/// Kotak ringkasan fakta (key-value). Disembunyikan bila kosong.
class WikiInfobox extends StatelessWidget {
  const WikiInfobox({super.key, required this.infoboxData});

  final Map<String, dynamic> infoboxData;

  @override
  Widget build(BuildContext context) {
    if (infoboxData.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        border: Border.all(color: const Color(0xFFE1E4E8)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: infoboxData.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    entry.key,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF202122),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    entry.value.toString(),
                    style: const TextStyle(color: Color(0xFF202122)),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
