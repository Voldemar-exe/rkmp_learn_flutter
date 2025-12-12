// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RecipesViewModel)
const recipesViewModelProvider = RecipesViewModelProvider._();

final class RecipesViewModelProvider
    extends $AsyncNotifierProvider<RecipesViewModel, RecipesState> {
  const RecipesViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recipesViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recipesViewModelHash();

  @$internal
  @override
  RecipesViewModel create() => RecipesViewModel();
}

String _$recipesViewModelHash() => r'6cfe6eca07114feed5770cb2593066c76833ef54';

abstract class _$RecipesViewModel extends $AsyncNotifier<RecipesState> {
  FutureOr<RecipesState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<RecipesState>, RecipesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RecipesState>, RecipesState>,
              AsyncValue<RecipesState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
