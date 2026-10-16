import 'package:flutter/material.dart';

class CommunityTab extends StatelessWidget {
  const CommunityTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 30),
          child: Container(
            constraints: const BoxConstraints(minHeight: 78),
            padding: const EdgeInsets.fromLTRB(16, 16, 10, 16),
            decoration: BoxDecoration(color: const Color(0xFFEAECF0), borderRadius: BorderRadius.circular(28)),
            child: Row(children: [
              const Expanded(child: Text('Content and resources selected by and about the Wikimedia community', style: TextStyle(color: Color(0xFF54595D), fontSize: 15, height: 1.45))),
              const SizedBox(width: 8),
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/8/8b/Wikipedia_wordmark.svg',
                width: 52,
                height: 52,
                errorBuilder: (_, __, ___) => const Icon(Icons.public, size: 48, color: Color(0xFF72777D)),
              ),
            ]),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 18),
          child: Text('Today - 15 Okt 2026', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF54595D))),
        ),
        Container(
          color: const Color(0xFFF8F9FA),
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const Expanded(child: Text('Bacaan teratas', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF202122)))),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Color(0xFF202122))),
            ]),
            const SizedBox(height: 2),
            const Text('Apa yang sedang tren hari ini di Wikipedia?', style: TextStyle(fontSize: 15, color: Color(0xFF54595D))),
            const SizedBox(height: 26),
            const Divider(height: 1, color: Color(0xFFE1E4E8)),
            const _TrendingRow(rank: '1', title: 'Louis Slotin', views: '14 rb ditengok', imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Louis_Slotin.jpg/120px-Louis_Slotin.jpg'),
            const _TrendingRow(rank: '2', title: 'Martha Tilaar', views: '12 rb ditengok', imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Martha_Tilaar.jpg/120px-Martha_Tilaar.jpg'),
            const _TrendingRow(rank: '3', title: 'Suroso Isnandar', views: '7,6 rb ditengok', imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Portrait_placeholder.png/120px-Portrait_placeholder.png'),
            const _TrendingRow(rank: '4', title: 'Sejarah dunia', views: '6,9 rb ditengok', imageUrl: 'https://images.unsplash.com/photo-1461360370896-922624d12aa1?w=160&h=160&fit=crop'),
          ]),
        ),
      ],
    );
  }
}

class _TrendingRow extends StatelessWidget {
  const _TrendingRow({required this.rank, required this.title, required this.views, required this.imageUrl});
  final String rank;
  final String title;
  final String views;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE1E4E8)))),
      child: Row(children: [
        Container(width: 25, height: 25, alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFF3366CC), borderRadius: BorderRadius.circular(4)), child: Text(rank, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15))),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF202122))),
          const SizedBox(height: 14),
          Row(children: [const Icon(Icons.trending_up, size: 21, color: Color(0xFF14866D)), const SizedBox(width: 8), Flexible(child: Text(views, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF54595D))))]),
        ])),
        const SizedBox(width: 12),
        ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(imageUrl, width: 58, height: 58, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 58, height: 58, color: const Color(0xFFEAECF0), child: const Icon(Icons.article_outlined, color: Color(0xFF72777D)))),),
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Color(0xFF72777D))),
      ]),
    );
  }
}
