import 'package:flutter/material.dart';

import '../../../models/dto/community_feed.dart';
import '../../../repositories/community_repository.dart';


const _blue = Color(0xFF3366CC);
const _text = Color(0xFF202122);
const _muted = Color(0xFF54595D);
const _line = Color(0xFFE1E4E8);
const _panel = Color(0xFFF8F9FA);


class CommunityTab extends StatefulWidget {
  const CommunityTab({super.key});

  @override
  State<CommunityTab> createState() => _CommunityTabState();
}


class _CommunityTabState extends State<CommunityTab> {
  final _repository = CommunityRepository();
  late Future<CommunityFeed> _feed;

  @override
  void initState() {
    super.initState();
    _feed = _repository.fetchFeed();
  }

  Future<void> _refresh() async {
    final request = _repository.fetchFeed();
    setState(() => _feed = request);
    await request;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: FutureBuilder<CommunityFeed>(
        future: _feed,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _ErrorView(onRetry: _refresh);
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: _blue),
            );
          }

          return _CommunityContent(
            feed: snapshot.requireData,
            onRefresh: _refresh,
          );
        },
      ),
    );
  }
}


class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off_outlined,
              size: 42,
              color: _muted,
            ),
            const SizedBox(height: 12),
            const Text(
              'Konten Community tidak dapat dimuat',
              textAlign: TextAlign.center,
              style: TextStyle(color: _text, fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              'Periksa koneksi dan alamat API, lalu coba lagi.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _muted),
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: () => onRetry(),
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}


class _CommunityContent extends StatelessWidget {
  const _CommunityContent({
    required this.feed,
    required this.onRefresh,
  });

  final CommunityFeed feed;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: _blue,
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEAECF0),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Konten dan sumber pilihan komunitas Wikimedia',
                      style: TextStyle(
                        color: _muted,
                        fontSize: 16,
                        height: 1.45,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.public, size: 50, color: _muted),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
            child: Text(
              'Hari ini · ${_formatDate(feed.date)}',
              style: const TextStyle(
                color: _muted,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (feed.featuredArticle != null)
            _FeaturedSection(
              article: feed.featuredArticle!,
              source: feed.featuredArticleSource,
            ),
          if (feed.didYouKnow.isNotEmpty)
            _FactsSection(facts: feed.didYouKnow),
          if (feed.inTheNews.isNotEmpty)
            _NewsSection(articles: feed.inTheNews),
          if (feed.onThisDay.isNotEmpty)
            _OnThisDaySection(events: feed.onThisDay),
          if (feed.trending.isNotEmpty)
            _TrendingSection(articles: feed.trending),
        ],
      ),
    );
  }
}


String _formatDate(DateTime date) {
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
  ];

  return '${date.day} ${months[date.month - 1]} ${date.year}';
}


class _FeaturedSection extends StatelessWidget {
  const _FeaturedSection({
    required this.article,
    required this.source,
  });

  final CommunityArticle article;
  final String source;

  @override
  Widget build(BuildContext context) {
    final imageUrl = article.bannerImageUrl;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Artikel pilihan',
            style: const TextStyle(
              color: _text,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            source == 'featured'
                ? 'Artikel pilihan komunitas'
                : 'Bacaan populer dari pembaca WikiPiye',
            style: const TextStyle(color: _muted, fontSize: 15),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: SizedBox(
              height: 360,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (imageUrl != null && imageUrl.isNotEmpty)
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const ColoredBox(color: Color(0xFF999999)),
                    )
                  else
                    const ColoredBox(color: Color(0xFF999999)),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0xDD000000),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Row(
                      children: [
                        _ActionButton(
                          icon: Icons.bookmark_border,
                          label: 'Simpan artikel',
                        ),
                        const SizedBox(width: 8),
                        _ActionButton(
                          icon: Icons.share_outlined,
                          label: 'Bagikan artikel',
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 18,
                    right: 18,
                    bottom: 18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Georgia',
                            fontSize: 27,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          article.extract,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 22),
          const Divider(height: 1, color: _line),
        ],
      ),
    );
  }
}


class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xCC111315),
      shape: const CircleBorder(),
      child: IconButton(
        tooltip: label,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$label belum tersedia.')),
          );
        },
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }
}


class _FactsSection extends StatelessWidget {
  const _FactsSection({required this.facts});

  final List<String> facts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tahukah Anda?',
            style: TextStyle(color: _text, fontSize: 24),
          ),
          const SizedBox(height: 6),
          const Text(
            'Fakta menarik dari artikel pilihan para kontributor',
            style: TextStyle(color: _muted, fontSize: 15),
          ),
          const SizedBox(height: 18),
          ...facts.map(
            (fact) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: _blue,
                    child: Text(
                      '?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      fact,
                      style: const TextStyle(
                        color: _text,
                        fontSize: 17,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: _line),
        ],
      ),
    );
  }
}


class _NewsSection extends StatefulWidget {
  const _NewsSection({required this.articles});

  final List<CommunityArticle> articles;

  @override
  State<_NewsSection> createState() => _NewsSectionState();
}


class _NewsSectionState extends State<_NewsSection> {
  late final PageController _controller;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Berita terkini',
            style: TextStyle(color: _text, fontSize: 24),
          ),
          const SizedBox(height: 6),
          const Text(
            'Artikel yang diperbarui untuk mencerminkan peristiwa terbaru',
            style: TextStyle(color: _muted, fontSize: 15),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 360,
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.articles.length,
              onPageChanged: (index) => setState(() => _page = index),
              itemBuilder: (context, index) =>
                  _NewsCard(article: widget.articles[index]),
            ),
          ),
          if (widget.articles.length > 1) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.articles.length,
                (index) => Container(
                  width: 9,
                  height: 9,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == _page
                        ? const Color(0xFF6D9EFF)
                        : const Color(0xFF9AA0A6),
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 14),
          const Divider(height: 1, color: _line),
        ],
      ),
    );
  }
}


class _NewsCard extends StatelessWidget {
  const _NewsCard({required this.article});

  final CommunityArticle article;

  @override
  Widget build(BuildContext context) {
    final imageUrl = article.bannerImageUrl;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (imageUrl != null && imageUrl.isNotEmpty)
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const ColoredBox(color: Color(0xFF999999)),
            )
          else
            const ColoredBox(color: Color(0xFF999999)),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xDD000000)],
              ),
            ),
          ),
          Positioned(
            left: 18,
            right: 18,
            bottom: 18,
            child: Text(
              '${article.title}\n\n${article.extract}',
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _OnThisDaySection extends StatelessWidget {
  const _OnThisDaySection({required this.events});

  final List<CommunityEvent> events;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pada hari ini',
            style: TextStyle(color: _text, fontSize: 24),
          ),
          const SizedBox(height: 12),
          ...events.map(
            (event) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                '${event.year} · ${event.yearsAgo} tahun lalu',
                style: const TextStyle(color: _blue),
              ),
              subtitle: Text(
                event.description,
                style: const TextStyle(color: _text, height: 1.5),
              ),
            ),
          ),
          const Divider(height: 1, color: _line),
        ],
      ),
    );
  }
}


class _TrendingSection extends StatelessWidget {
  const _TrendingSection({required this.articles});

  final List<CommunityArticle> articles;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _panel,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bacaan teratas',
            style: TextStyle(
              color: _text,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Apa yang sedang tren hari ini di Wikipedia?',
            style: TextStyle(color: _muted, fontSize: 15),
          ),
          const SizedBox(height: 18),
          ...articles.asMap().entries.map(
            (entry) => _TrendingRow(
              article: entry.value,
              rank: entry.key + 1,
            ),
          ),
        ],
      ),
    );
  }
}


class _TrendingRow extends StatelessWidget {
  const _TrendingRow({
    required this.article,
    required this.rank,
  });

  final CommunityArticle article;
  final int rank;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _line)),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _blue,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              '$rank',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.trending_up,
                      size: 20,
                      color: Color(0xFF14866D),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      '${article.viewCount} kali dilihat',
                      style: const TextStyle(
                        color: _muted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          if (article.bannerImageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                article.bannerImageUrl!,
                width: 58,
                height: 58,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _imagePlaceholder(),
              ),
            )
          else
            _imagePlaceholder(),
          const SizedBox(width: 5),
          const Icon(Icons.more_vert, color: _muted),
        ],
      ),
    );
  }
}


Widget _imagePlaceholder() {
  return Container(
    width: 58,
    height: 58,
    color: const Color(0xFFEAECF0),
    alignment: Alignment.center,
    child: const Icon(Icons.article_outlined, color: _muted),
  );
}