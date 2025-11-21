// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_recipes_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userRecipes)
const userRecipesProvider = UserRecipesProvider._();

final class UserRecipesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Recipe>>,
          List<Recipe>,
          FutureOr<List<Recipe>>
        >
    with $FutureModifier<List<Recipe>>, $FutureProvider<List<Recipe>> {
  const UserRecipesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRecipesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRecipesHash();

  @$internal
  @override
  $FutureProviderElement<List<Recipe>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Recipe>> create(Ref ref) {
    return userRecipes(ref);
  }
}

String _$userRecipesHash() => r'b05f4d8a0278827508d9bee58d66ff9ed6158b0d';
