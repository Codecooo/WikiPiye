import 'package:flutter/material.dart';
import 'package:wikipiye/ui/article_detail/article_detail_screen.dart';
import '../../../services/wiki_api.dart';

String formatViews(dynamic value) {
  final views = num.tryParse(value?.toString() ?? '');

  if (views == null || !views.isFinite || views < 0) {
    return 'Jumlah kunjungan belum tersedia';
  }

  String formatNumber(double number) {
    return number.toStringAsFixed(1).replaceAll('.', ',');
  }

  if (views >= 1000000000) {
    return '${formatNumber(views / 1000000000)}B views';
  }

  if (views >= 1000000) {
    return '${formatNumber(views / 1000000)}M views';
  }

  if (views >= 1000) {
    return '${formatNumber(views / 1000)}K views';
  }

  return '${views.toInt()} views';
}

class CommunityTab extends StatefulWidget {
  const CommunityTab({super.key});

  @override
  State<CommunityTab> createState() => _CommunityTabState();
}

class _CommunityTabState extends State<CommunityTab> {
  late Future<Map<String, dynamic>> _communityFuture;

  @override
  void initState() {
    super.initState();
    _communityFuture = _fetchCommunityData();
  }

  Future<Map<String, dynamic>> _fetchCommunityData() async {
    // Memanggil endpoint aktif secara paralel
    final results = await Future.wait([
      WikiApi.instance.forYou(limit: 5),
      WikiApi.instance.trending(limit: 5),
      WikiApi.instance.facts(),
    ]);

    final forYouData = results[0] as Map<String, dynamic>;
    final trendingList = results[1] as List<Map<String, dynamic>>;
    final factsList = results[2] as List<String>;

    return {
      'featuredArticle': forYouData['featured_article'],
      'inTheNews': forYouData['in_the_news'] ?? [],
      'trending': trendingList,
      'didYouKnow': factsList,
    };
  }

  Future<void> _reload() async {
    setState(() {
      _communityFuture = _fetchCommunityData();
    });

    try {
      await _communityFuture;
    } catch (_) {
      // Error ditangani oleh FutureBuilder
    }
  }

  void _navigateToArticle(dynamic articleId) {
    if (articleId == null) return;
    
    // Konversi id ke format String atau int sesuai kebutuhan skema kamu
    final parsedId = articleId.toString();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(articleId: parsedId),
      ),
    );
  }

  String _text(dynamic value, [String fallback = '']) {
    if (value == null) return fallback;
    return value.toString();
  }

  List<dynamic> _list(dynamic value) {
    return value is List ? value : <dynamic>[];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _communityFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.cloud_off_outlined,
                    size: 48,
                    color: Color(0xFF72777D),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Konten Community tidak dapat dimuat.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Periksa koneksi dan alamat API, lalu coba lagi.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF54595D)),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _reload,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          );
        }

        final data = snapshot.data ?? {};
        final trending = _list(data['trending']);
        final news = _list(data['inTheNews']);
        final facts = _list(data['didYouKnow']);
        final featured = data['featuredArticle'];

        return RefreshIndicator(
          onRefresh: _reload,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              _introCard(),

              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 18),
                child: Text(
                  'Community WikiPiye',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF54595D),
                  ),
                ),
              ),

              if (featured is Map<String, dynamic>)
                _section(
                  title: 'Artikel pilihan',
                  subtitle: 'Pilihan komunitas',
                  children: [
                    _contentCard(
                      title: _text(featured['title'], 'Artikel pilihan'),
                      description: _text(featured['summary']),
                      imageUrl: _text(featured['banner_image_url']),
                      onTap: () => _navigateToArticle(featured['id']),
                    ),
                  ],
                ),

              _section(
                title: 'Bacaan teratas',
                subtitle: 'Artikel yang sedang populer',
                children: trending.isEmpty
                    ? [_emptyText('Belum ada bacaan teratas.')]
                    : trending.map((item) {
                        if (item is! Map) {
                          return const SizedBox.shrink();
                        }

                        final article = Map<String, dynamic>.from(item);

                        return _trendingRow(
                          rank: '${trending.indexOf(item) + 1}',
                          title: _text(article['title'], 'Artikel tanpa judul'),
                          views: formatViews(
                            article['view_count'] ?? article['views'],
                          ),
                          imageUrl: _text(
                            article['banner_image_url'] ?? article['imageUrl'],
                          ),
                          onTap: () => _navigateToArticle(article['id']),
                        );
                      }).toList(),
              ),

              _section(
                title: 'Dalam berita',
                subtitle: 'Artikel yang berkaitan dengan berita terkini',
                children: news.isEmpty
                    ? [_emptyText('Belum ada berita untuk ditampilkan.')]
                    : news.map((item) {
                        if (item is! Map) {
                          return const SizedBox.shrink();
                        }

                        final article = Map<String, dynamic>.from(item);

                        return _contentCard(
                          title: _text(article['title'], 'Berita tanpa judul'),
                          description: _text(
                            article['summary'] ?? article['description'],
                          ),
                          imageUrl: _text(
                            article['banner_image_url'] ?? article['imageUrl'],
                          ),
                          onTap: () => _navigateToArticle(article['id']),
                        );
                      }).toList(),
              ),

              _section(
                title: 'Tahukah kamu?',
                subtitle: 'Fakta menarik dari artikel',
                children: facts.isEmpty
                    ? [_emptyText('Belum ada fakta untuk ditampilkan.')]
                    : facts.map((item) {
                        return _contentCard(
                          title: 'Fakta Menarik',
                          description: _text(item),
                          // Fakta FYI dari API berupa array String sederhana tanpa ID artikel
                        );
                      }).toList(),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: TextButton.icon(
                    onPressed: _reload,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Muat ulang Community'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _introCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 30),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEAECF0),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Row(
          children: [
            Expanded(
              child: Text(
                'Konten dan sumber pilihan dari komunitas WikiPiye.',
                style: TextStyle(
                  color: Color(0xFF54595D),
                  fontSize: 15,
                  height: 1.45,
                ),
              ),
            ),
            SizedBox(width: 12),
            Icon(Icons.public, size: 48, color: Color(0xFF72777D)),
          ],
        ),
      ),
    );
  }

  Widget _section({
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Container(
      color: const Color(0xFFF8F9FA),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202122),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: Color(0xFF54595D)),
          ),
          const SizedBox(height: 18),
          const Divider(height: 1, color: Color(0xFFE1E4E8)),
          ...children,
        ],
      ),
    );
  }

  Widget _trendingRow({
    required String rank,
    required String title,
    required String views,
    required String imageUrl,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      highlightColor: const Color(0xFFEAECF0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE1E4E8))),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF3366CC),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                rank,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202122),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.visibility_outlined,
                        size: 15,
                        color: Color(0xFF54595D),
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          views,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF54595D),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (imageUrl.isNotEmpty) ...[
              const SizedBox(width: 10),
              _networkImage(imageUrl, 58),
            ],
          ],
        ),
      ),
    );
  }

  Widget _contentCard({
    required String title,
    String description = '',
    String imageUrl = '',
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      highlightColor: const Color(0xFFEAECF0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE1E4E8))),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202122),
                    ),
                  ),
                  if (description.isNotEmpty) ...[
                    const SizedBox(height: 7),
                    Text(
                      description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Color(0xFF54595D),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (imageUrl.isNotEmpty) ...[
              const SizedBox(width: 12),
              _networkImage(imageUrl, 72),
            ],
          ],
        ),
      ),
    );
  }

  Widget _networkImage(String url, double size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: const Color(0xFFEAECF0),
            alignment: Alignment.center,
            child: const Icon(Icons.article_outlined, color: Color(0xFF72777D)),
          );
        },
      ),
    );
  }

  Widget _emptyText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFF72777D), fontSize: 14),
      ),
    );
  }
}