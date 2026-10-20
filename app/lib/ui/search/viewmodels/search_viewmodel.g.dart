// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Hasil pencarian untuk [query]. Request yang masih berjalan dibatalkan
/// otomatis saat query berganti (provider lama di-dispose).

@ProviderFor(searchResults)
final searchResultsProvider = SearchResultsFamily._();

/// Hasil pencarian untuk [query]. Request yang masih berjalan dibatalkan
/// otomatis saat query berganti (provider lama di-dispose).

final class SearchResultsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Article>>,
          List<Article>,
          FutureOr<List<Article>>
        >
    with $FutureModifier<List<Article>>, $FutureProvider<List<Article>> {
  /// Hasil pencarian untuk [query]. Request yang masih berjalan dibatalkan
  /// otomatis saat query berganti (provider lama di-dispose).
  SearchResultsProvider._({
    required SearchResultsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'searchResultsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchResultsHash();

  @override
  String toString() {
    return r'searchResultsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Article>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Article>> create(Ref ref) {
    final argument = this.argument as String;
    return searchResults(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchResultsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchResultsHash() => r'd0d8ad470e26295072e5408f9aad8b902d8381b5';

/// Hasil pencarian untuk [query]. Request yang masih berjalan dibatalkan
/// otomatis saat query berganti (provider lama di-dispose).

final class SearchResultsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Article>>, String> {
  SearchResultsFamily._()
    : super(
        retry: null,
        name: r'searchResultsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Hasil pencarian untuk [query]. Request yang masih berjalan dibatalkan
  /// otomatis saat query berganti (provider lama di-dispose).

  SearchResultsProvider call(String query) =>
      SearchResultsProvider._(argument: query, from: this);

  @override
  String toString() => r'searchResultsProvider';
}

/// Artikel populer, ditampilkan saat kolom pencarian masih kosong.

@ProviderFor(trendingArticles)
final trendingArticlesProvider = TrendingArticlesProvider._();

/// Artikel populer, ditampilkan saat kolom pencarian masih kosong.

final class TrendingArticlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Article>>,
          List<Article>,
          FutureOr<List<Article>>
        >
    with $FutureModifier<List<Article>>, $FutureProvider<List<Article>> {
  /// Artikel populer, ditampilkan saat kolom pencarian masih kosong.
  TrendingArticlesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trendingArticlesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trendingArticlesHash();

  @$internal
  @override
  $FutureProviderElement<List<Article>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Article>> create(Ref ref) {
    return trendingArticles(ref);
  }
}

String _$trendingArticlesHash() => r'c5cc1711fc2831b4b1a1f36a02c574b19d8bf96d';
