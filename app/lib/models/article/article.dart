import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
abstract class Article with _$Article {
  const factory Article({
    required String id,
    required String title,
    required String summary,
    required String bannerImageUrl,
    required List<String> category,
    required EditProtectionLevel editProtectionLevel,
    
    // Konten disimpan sebagai daftar Section
    required List<ArticleSection> sections,
    
    required DateTime createdAt,
    required DateTime updatedAt,
    int? viewCount,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}

@freezed
abstract class ArticleSection with _$ArticleSection {
  const factory ArticleSection({
    required String id,
    required String heading,
    @Default(1) int level, // H1, H2, H3
    
    // Content Delta / Block Data dari Editor (misal: Flutter Quill Delta JSON)
    required List<Map<String, dynamic>> contentDelta, 
  }) = _ArticleSection;

  factory ArticleSection.fromJson(Map<String, dynamic> json) => _$ArticleSectionFromJson(json);
}

enum EditProtectionLevel {
  open,
  semi,
  full,
}