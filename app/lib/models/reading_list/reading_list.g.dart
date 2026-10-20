// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReadingList _$ReadingListFromJson(Map<String, dynamic> json) => _ReadingList(
  userId: json['userId'] as String,
  articleId: json['articleId'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ReadingListToJson(_ReadingList instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'articleId': instance.articleId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
