import 'package:flutter/material.dart';

class WikiBottomNavigation extends StatelessWidget {
  const WikiBottomNavigation({super.key, required this.selectedIndex, required this.onTap, required this.dark});
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final bool dark;

  static const _items = [
    (Icons.home_filled, 'Beranda'),
    (Icons.bookmark_border, 'Tersimpan'),
    (Icons.search, 'Cari'),
    (Icons.history, 'Aktivitas'),
    (Icons.menu, 'Selebihnya'),
  ];

  @override
  Widget build(BuildContext context) {
    final bar = dark ? Colors.black : Colors.white;
    final inactive = dark ? const Color(0xFF9AA0A6) : const Color(0xFF72777D);
    return Container(
      decoration: BoxDecoration(color: bar, border: Border(top: BorderSide(color: dark ? Colors.black : const Color(0xFFE1E4E8)))),
      padding: const EdgeInsets.fromLTRB(4, 7, 4, 8),
      child: SafeArea(
        top: false,
        child: Row(children: List.generate(_items.length, (index) {
          final selected = selectedIndex == index;
          final item = _items[index];
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => onTap(index),
              child: Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 1),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 64,
                    height: 34,
                    decoration: BoxDecoration(color: selected ? (dark ? const Color(0xFF101B34) : const Color(0xFFEAF1FF)) : Colors.transparent, borderRadius: BorderRadius.circular(22)),
                    child: Stack(alignment: Alignment.center, children: [
                      Icon(item.$1, size: 26, color: selected ? const Color(0xFF3366CC) : inactive),
                      if (index == 1) Positioned(right: 14, top: 5, child: Container(width: 7, height: 7, decoration: const BoxDecoration(color: Color(0xFFB32424), shape: BoxShape.circle))),
                    ]),
                  ),
                  const SizedBox(height: 5),
                  FittedBox(fit: BoxFit.scaleDown, child: Text(item.$2, maxLines: 1, style: TextStyle(fontSize: 11, fontWeight: selected ? FontWeight.w700 : FontWeight.w500, color: selected ? const Color(0xFF3366CC) : inactive))),
                ]),
              ),
            ),
          );
        })),
      ),
    );
  }
}
