import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wikipiye/main.dart';
import 'package:wikipiye/models/article/article.dart';
import 'package:wikipiye/repositories/article_repository.dart';

part 'article_detail_viewmodel.g.dart';

@riverpod
class ArticleDetailViewmodel extends _$ArticleDetailViewmodel {
  @override
  Future<Article> build(String articleId) {
    return getIt<ArticleRepository>().fetchArticleById(articleId);
  }
}
