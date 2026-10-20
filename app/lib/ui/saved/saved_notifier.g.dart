// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Artikel yang disimpan (terbaru di atas). Dipakai bersama oleh layar
/// Tersimpan dan tombol bookmark di Detail Artikel.

@ProviderFor(SavedArticles)
final savedArticlesProvider = SavedArticlesProvider._();

/// Artikel yang disimpan (terbaru di atas). Dipakai bersama oleh layar
/// Tersimpan dan tombol bookmark di Detail Artikel.
final class SavedArticlesProvider
    extends $AsyncNotifierProvider<SavedArticles, List<Article>> {
  /// Artikel yang disimpan (terbaru di atas). Dipakai bersama oleh layar
  /// Tersimpan dan tombol bookmark di Detail Artikel.
  SavedArticlesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedArticlesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedArticlesHash();

  @$internal
  @override
  SavedArticles create() => SavedArticles();
}

String _$savedArticlesHash() => r'18884c974b4a927cd41ed296f15969e1dfb38bc7';

/// Artikel yang disimpan (terbaru di atas). Dipakai bersama oleh layar
/// Tersimpan dan tombol bookmark di Detail Artikel.

abstract class _$SavedArticles extends $AsyncNotifier<List<Article>> {
  FutureOr<List<Article>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Article>>, List<Article>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Article>>, List<Article>>,
              AsyncValue<List<Article>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Apakah artikel [articleId] sedang tersimpan.

@ProviderFor(isArticleSaved)
final isArticleSavedProvider = IsArticleSavedFamily._();

/// Apakah artikel [articleId] sedang tersimpan.

final class IsArticleSavedProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Apakah artikel [articleId] sedang tersimpan.
  IsArticleSavedProvider._({
    required IsArticleSavedFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'isArticleSavedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isArticleSavedHash();

  @override
  String toString() {
    return r'isArticleSavedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as String;
    return isArticleSaved(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IsArticleSavedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isArticleSavedHash() => r'b281128b64bd3727fd9a115a45e8e988b968da13';

/// Apakah artikel [articleId] sedang tersimpan.

final class IsArticleSavedFamily extends $Family
    with $FunctionalFamilyOverride<bool, String> {
  IsArticleSavedFamily._()
    : super(
        retry: null,
        name: r'isArticleSavedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Apakah artikel [articleId] sedang tersimpan.

  IsArticleSavedProvider call(String articleId) =>
      IsArticleSavedProvider._(argument: articleId, from: this);

  @override
  String toString() => r'isArticleSavedProvider';
}
