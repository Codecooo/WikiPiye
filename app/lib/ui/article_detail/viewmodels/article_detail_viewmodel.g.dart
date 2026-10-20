// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_detail_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArticleDetailViewmodel)
final articleDetailViewmodelProvider = ArticleDetailViewmodelFamily._();

final class ArticleDetailViewmodelProvider
    extends $AsyncNotifierProvider<ArticleDetailViewmodel, Article> {
  ArticleDetailViewmodelProvider._({
    required ArticleDetailViewmodelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'articleDetailViewmodelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articleDetailViewmodelHash();

  @override
  String toString() {
    return r'articleDetailViewmodelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ArticleDetailViewmodel create() => ArticleDetailViewmodel();

  @override
  bool operator ==(Object other) {
    return other is ArticleDetailViewmodelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articleDetailViewmodelHash() =>
    r'30901f664a286e392704136d7e8a397a802bff71';

final class ArticleDetailViewmodelFamily extends $Family
    with
        $ClassFamilyOverride<
          ArticleDetailViewmodel,
          AsyncValue<Article>,
          Article,
          FutureOr<Article>,
          String
        > {
  ArticleDetailViewmodelFamily._()
    : super(
        retry: null,
        name: r'articleDetailViewmodelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArticleDetailViewmodelProvider call(String articleId) =>
      ArticleDetailViewmodelProvider._(argument: articleId, from: this);

  @override
  String toString() => r'articleDetailViewmodelProvider';
}

abstract class _$ArticleDetailViewmodel extends $AsyncNotifier<Article> {
  late final _$args = ref.$arg as String;
  String get articleId => _$args;

  FutureOr<Article> build(String articleId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Article>, Article>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Article>, Article>,
              AsyncValue<Article>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
