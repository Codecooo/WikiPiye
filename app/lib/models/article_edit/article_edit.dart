import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_edit.freezed.dart';
part 'article_edit.g.dart';

@freezed
abstract class ArticleEdit with _$ArticleEdit {
  const factory ArticleEdit({
    required String id,
    required String articleId,
    required String title,
    required String editSummary, 
    
    required List<Map<String, dynamic>> contentDelta,
    String? editorId,    
    String? editorIpAddress,    
    required DateTime editedAt,
  }) = _ArticleEdit;

  factory ArticleEdit.fromJson(Map<String, dynamic> json) => _$ArticleEditFromJson(json);
}