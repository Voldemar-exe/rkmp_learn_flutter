import 'package:rkmp_learn_flutter/features/ingredients/domain/repositories/ingredient_repository.dart';

class GetUserIngredientsWithAmountUseCase {
  final IngredientRepository _repository;

  GetUserIngredientsWithAmountUseCase(this._repository);

  Future<Map<String, double>> call() async {
    final ingredients = await _repository.getUserIngredients();
    return {
      for (final ingredient in ingredients)
        ingredient.name: ?ingredient.amount,
    };
  }
}