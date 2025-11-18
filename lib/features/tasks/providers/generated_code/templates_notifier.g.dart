// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../templates_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TemplatesNotifier)
const templatesProvider = TemplatesNotifierProvider._();

final class TemplatesNotifierProvider
    extends $NotifierProvider<TemplatesNotifier, List<TaskTemplate>> {
  const TemplatesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'templatesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$templatesNotifierHash();

  @$internal
  @override
  TemplatesNotifier create() => TemplatesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TaskTemplate> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TaskTemplate>>(value),
    );
  }
}

String _$templatesNotifierHash() => r'6e29141e4114511821acd56e4e8df9d0d573b694';

abstract class _$TemplatesNotifier extends $Notifier<List<TaskTemplate>> {
  List<TaskTemplate> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<TaskTemplate>, List<TaskTemplate>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<TaskTemplate>, List<TaskTemplate>>,
              List<TaskTemplate>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
