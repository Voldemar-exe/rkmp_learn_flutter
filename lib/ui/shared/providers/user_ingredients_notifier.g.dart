// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_ingredients_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userIngredients)
const userIngredientsProvider = UserIngredientsProvider._();

final class UserIngredientsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, double>>,
          Map<String, double>,
          FutureOr<Map<String, double>>
        >
    with
        $FutureModifier<Map<String, double>>,
        $FutureProvider<Map<String, double>> {
  const UserIngredientsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userIngredientsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userIngredientsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, double>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, double>> create(Ref ref) {
    return userIngredients(ref);
  }
}

String _$userIngredientsHash() => r'be39e66fcb44db00bf5db3175ebb10345ac21a33';
