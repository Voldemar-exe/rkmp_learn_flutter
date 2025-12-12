// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_picker_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ColorPickerNotifier)
const colorPickerProvider = ColorPickerNotifierProvider._();

final class ColorPickerNotifierProvider
    extends $NotifierProvider<ColorPickerNotifier, Color> {
  const ColorPickerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'colorPickerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$colorPickerNotifierHash();

  @$internal
  @override
  ColorPickerNotifier create() => ColorPickerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Color value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Color>(value),
    );
  }
}

String _$colorPickerNotifierHash() =>
    r'7de62b4ee690fdbc15eadafe602ee0d97744e3ff';

abstract class _$ColorPickerNotifier extends $Notifier<Color> {
  Color build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Color, Color>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Color, Color>,
              Color,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
