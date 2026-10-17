import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/article/article.dart';
import '../../repositories/article_repository.dart';

final articleDetailProvider = FutureProvider.autoDispose
    .family<Article, String>((ref, articleId) {
      return ref.watch(articleRepositoryProvider).fetchArticleById(articleId);
    });
