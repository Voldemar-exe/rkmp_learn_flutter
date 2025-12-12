// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StatisticsViewModel)
const statisticsViewModelProvider = StatisticsViewModelProvider._();

final class StatisticsViewModelProvider
    extends $AsyncNotifierProvider<StatisticsViewModel, StatisticsState> {
  const StatisticsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statisticsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statisticsViewModelHash();

  @$internal
  @override
  StatisticsViewModel create() => StatisticsViewModel();
}

String _$statisticsViewModelHash() =>
    r'78929382728116fe917209cda97dc28d8f3f3351';

abstract class _$StatisticsViewModel extends $AsyncNotifier<StatisticsState> {
  FutureOr<StatisticsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<StatisticsState>, StatisticsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<StatisticsState>, StatisticsState>,
              AsyncValue<StatisticsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
