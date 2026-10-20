import 'package:freezed_annotation/freezed_annotation.dart';

part 'reading_list.freezed.dart';
part 'reading_list.g.dart';

@freezed
abstract class ReadingList with _$ReadingList {
  const factory ReadingList({
    required String userId,
    required String articleId,
    required DateTime createdAt,
  }) = _ReadingList;

  factory ReadingList.fromJson(Map<String, dynamic> json) =>
      _$ReadingListFromJson(json);
}
