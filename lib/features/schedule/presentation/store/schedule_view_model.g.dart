// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScheduleViewModel)
const scheduleViewModelProvider = ScheduleViewModelProvider._();

final class ScheduleViewModelProvider
    extends $AsyncNotifierProvider<ScheduleViewModel, ScheduleState> {
  const ScheduleViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scheduleViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scheduleViewModelHash();

  @$internal
  @override
  ScheduleViewModel create() => ScheduleViewModel();
}

String _$scheduleViewModelHash() => r'a62cf9cf45e68be0d8fe50ceff4c8039b6f87366';

abstract class _$ScheduleViewModel extends $AsyncNotifier<ScheduleState> {
  FutureOr<ScheduleState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ScheduleState>, ScheduleState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ScheduleState>, ScheduleState>,
              AsyncValue<ScheduleState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
