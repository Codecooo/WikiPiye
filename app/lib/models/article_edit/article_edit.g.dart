// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArticleEdit _$ArticleEditFromJson(Map<String, dynamic> json) => _ArticleEdit(
  id: json['id'] as String,
  articleId: json['articleId'] as String,
  title: json['title'] as String,
  editSummary: json['editSummary'] as String,
  contentDelta: (json['contentDelta'] as List<dynamic>)
      .map((e) => e as Map<String, dynamic>)
      .toList(),
  editorId: json['editorId'] as String?,
  editorIpAddress: json['editorIpAddress'] as String?,
  editedAt: DateTime.parse(json['editedAt'] as String),
);

Map<String, dynamic> _$ArticleEditToJson(_ArticleEdit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'articleId': instance.articleId,
      'title': instance.title,
      'editSummary': instance.editSummary,
      'contentDelta': instance.contentDelta,
      'editorId': instance.editorId,
      'editorIpAddress': instance.editorIpAddress,
      'editedAt': instance.editedAt.toIso8601String(),
    };
