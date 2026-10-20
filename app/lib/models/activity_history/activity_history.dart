// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_history.freezed.dart';
part 'activity_history.g.dart';

@freezed
abstract class ActivityHistory with _$ActivityHistory {
  const factory ActivityHistory({
    required String userId,
    required ActivityType activityType,
    required String articleId,
    required DateTime timestamp,
  }) = _ActivityHistory;

  factory ActivityHistory.fromJson(Map<String, dynamic> json) =>
      _$ActivityHistoryFromJson(json);
  
}

enum ActivityType {
  ARTICLE_VIEW,
  ARTICLE_EDIT,
  ARTICLE_CREATE,
}