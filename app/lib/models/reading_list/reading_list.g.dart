// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReadingList _$ReadingListFromJson(Map<String, dynamic> json) => _ReadingList(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  articleIds:
      (json['articleIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ReadingListToJson(_ReadingList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'articleIds': instance.articleIds,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
