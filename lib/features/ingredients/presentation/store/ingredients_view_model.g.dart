// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredients_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IngredientsViewModel)
const ingredientsViewModelProvider = IngredientsViewModelProvider._();

final class IngredientsViewModelProvider
    extends $AsyncNotifierProvider<IngredientsViewModel, IngredientsListState> {
  const IngredientsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ingredientsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ingredientsViewModelHash();

  @$internal
  @override
  IngredientsViewModel create() => IngredientsViewModel();
}

String _$ingredientsViewModelHash() =>
    r'4b5ed7e6b2da9cd3609204adb06f6c6f68ad088d';

abstract class _$IngredientsViewModel
    extends $AsyncNotifier<IngredientsListState> {
  FutureOr<IngredientsListState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<IngredientsListState>, IngredientsListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<IngredientsListState>,
                IngredientsListState
              >,
              AsyncValue<IngredientsListState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
