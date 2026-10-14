// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Article _$ArticleFromJson(Map<String, dynamic> json) => _Article(
  id: json['id'] as String,
  title: json['title'] as String,
  summary: json['summary'] as String,
  bannerImageUrl: json['bannerImageUrl'] as String,
  category: (json['category'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  editProtectionLevel: $enumDecode(
    _$EditProtectionLevelEnumMap,
    json['editProtectionLevel'],
  ),
  sections: (json['sections'] as List<dynamic>)
      .map((e) => ArticleSection.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  viewCount: (json['viewCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$ArticleToJson(_Article instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'summary': instance.summary,
  'bannerImageUrl': instance.bannerImageUrl,
  'category': instance.category,
  'editProtectionLevel':
      _$EditProtectionLevelEnumMap[instance.editProtectionLevel]!,
  'sections': instance.sections,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'viewCount': instance.viewCount,
};

const _$EditProtectionLevelEnumMap = {
  EditProtectionLevel.open: 'open',
  EditProtectionLevel.semi: 'semi',
  EditProtectionLevel.full: 'full',
};

_ArticleSection _$ArticleSectionFromJson(Map<String, dynamic> json) =>
    _ArticleSection(
      id: json['id'] as String,
      heading: json['heading'] as String,
      level: (json['level'] as num?)?.toInt() ?? 1,
      contentDelta: (json['contentDelta'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ArticleSectionToJson(_ArticleSection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'heading': instance.heading,
      'level': instance.level,
      'contentDelta': instance.contentDelta,
    };
