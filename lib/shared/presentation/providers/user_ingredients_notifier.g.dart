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

String _$userIngredientsHash() => r'37b21e4de955367d8c85bdc61d98f0e18e862131';
