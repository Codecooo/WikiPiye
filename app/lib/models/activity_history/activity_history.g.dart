// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityHistory _$ActivityHistoryFromJson(Map<String, dynamic> json) =>
    _ActivityHistory(
      userId: json['userId'] as String,
      activityType: $enumDecode(_$ActivityTypeEnumMap, json['activityType']),
      articleId: json['articleId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$ActivityHistoryToJson(_ActivityHistory instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'activityType': _$ActivityTypeEnumMap[instance.activityType]!,
      'articleId': instance.articleId,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$ActivityTypeEnumMap = {
  ActivityType.ARTICLE_VIEW: 'ARTICLE_VIEW',
  ActivityType.ARTICLE_EDIT: 'ARTICLE_EDIT',
  ActivityType.ARTICLE_CREATE: 'ARTICLE_CREATE',
};
