// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_picker_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IconPickerNotifier)
const iconPickerProvider = IconPickerNotifierProvider._();

final class IconPickerNotifierProvider
    extends $NotifierProvider<IconPickerNotifier, String> {
  const IconPickerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'iconPickerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$iconPickerNotifierHash();

  @$internal
  @override
  IconPickerNotifier create() => IconPickerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$iconPickerNotifierHash() =>
    r'9fcb6f2a7607570da145fec9a1cef297b9e0d5a5';

abstract class _$IconPickerNotifier extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
