class CommunityFeed {
  const CommunityFeed({
    required this.date,
    required this.featuredArticle,
    required this.featuredArticleSource,
    required this.didYouKnow,
    required this.inTheNews,
    required this.trending,
    required this.onThisDay,
  });

  final DateTime date;
  final CommunityArticle? featuredArticle;
  final String featuredArticleSource;
  final List<String> didYouKnow;
  final List<CommunityArticle> inTheNews;
  final List<CommunityArticle> trending;
  final List<CommunityEvent> onThisDay;

  factory CommunityFeed.fromJson(Map<String, dynamic> json) {
    List<CommunityArticle> readArticles(String key) {
      final items = json[key] as List<dynamic>? ?? [];

      return items
          .map(
            (item) => CommunityArticle.fromJson(item as Map<String, dynamic>),
          )
          .toList(growable: false);
    }

    final rawFeatured = json['featuredArticle'];
    final rawFacts = json['didYouKnow'] as List<dynamic>? ?? [];
    final rawEvents = json['onThisDay'] as List<dynamic>? ?? [];

    return CommunityFeed(
      date: DateTime.parse(json['date'] as String),
      featuredArticle: rawFeatured == null
          ? null
          : CommunityArticle.fromJson(rawFeatured as Map<String, dynamic>),
      featuredArticleSource:
          json['featuredArticleSource'] as String? ?? 'popular',
      didYouKnow: rawFacts
          .map((item) => item as String)
          .toList(growable: false),
      inTheNews: readArticles('inTheNews'),
      trending: readArticles('trending'),
      onThisDay: rawEvents
          .map((item) => CommunityEvent.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
    );
  }
}

class CommunityArticle {
  const CommunityArticle({
    required this.id,
    required this.title,
    required this.extract,
    required this.bannerImageUrl,
    required this.category,
    required this.viewCount,
  });

  final String id;
  final String title;
  final String extract;
  final String? bannerImageUrl;
  final List<String> category;
  final int viewCount;

  factory CommunityArticle.fromJson(Map<String, dynamic> json) {
    final rawCategory = json['category'] as List<dynamic>? ?? [];

    return CommunityArticle(
      id: json['id'].toString(),
      title: json['title'] as String? ?? '',
      extract: json['extract'] as String? ?? '',
      bannerImageUrl: json['bannerImageUrl'] as String?,
      category: rawCategory
          .map((item) => item as String)
          .toList(growable: false),
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
    );
  }
}

class CommunityEvent {
  const CommunityEvent({
    required this.year,
    required this.yearsAgo,
    required this.description,
    this.articleTitle,
    this.articleId,
    this.imageUrl,
  });

  final int year;
  final int yearsAgo;
  final String description;
  final String? articleTitle;
  final String? articleId;
  final String? imageUrl;

  factory CommunityEvent.fromJson(Map<String, dynamic> json) {
    return CommunityEvent(
      year: (json['year'] as num).toInt(),
      yearsAgo: (json['yearsAgo'] as num).toInt(),
      description: json['description'] as String? ?? '',
      articleTitle: json['articleTitle'] as String?,
      articleId: json['articleId']?.toString(),
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
