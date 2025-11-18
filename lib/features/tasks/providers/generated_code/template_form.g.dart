// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../template_form.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TemplateForm)
const templateFormProvider = TemplateFormProvider._();

final class TemplateFormProvider
    extends $NotifierProvider<TemplateForm, TemplateFormData> {
  const TemplateFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'templateFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$templateFormHash();

  @$internal
  @override
  TemplateForm create() => TemplateForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TemplateFormData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TemplateFormData>(value),
    );
  }
}

String _$templateFormHash() => r'0d6e5f009795d2706b6b7b7c2d0e9d9c349c18b6';

abstract class _$TemplateForm extends $Notifier<TemplateFormData> {
  TemplateFormData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TemplateFormData, TemplateFormData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TemplateFormData, TemplateFormData>,
              TemplateFormData,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
