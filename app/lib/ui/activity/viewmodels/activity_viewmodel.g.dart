// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ActivityViewmodel)
final activityViewmodelProvider = ActivityViewmodelProvider._();

final class ActivityViewmodelProvider
    extends $AsyncNotifierProvider<ActivityViewmodel, List<ActivityHistory>> {
  ActivityViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activityViewmodelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activityViewmodelHash();

  @$internal
  @override
  ActivityViewmodel create() => ActivityViewmodel();
}

String _$activityViewmodelHash() => r'5e83da5afd935f7434d0b19b9bf7dcba3a287d40';

abstract class _$ActivityViewmodel
    extends $AsyncNotifier<List<ActivityHistory>> {
  FutureOr<List<ActivityHistory>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ActivityHistory>>, List<ActivityHistory>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ActivityHistory>>,
                List<ActivityHistory>
              >,
              AsyncValue<List<ActivityHistory>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
