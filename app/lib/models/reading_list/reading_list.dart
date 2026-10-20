import 'package:freezed_annotation/freezed_annotation.dart';

part 'reading_list.freezed.dart';
part 'reading_list.g.dart';

@freezed
abstract class ReadingList with _$ReadingList {
  const factory ReadingList({
    required String id,
    required String title,
    String? description,
    @Default([]) List<String> articleIds,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ReadingList;

  factory ReadingList.fromJson(Map<String, dynamic> json) => _$ReadingListFromJson(json);
}