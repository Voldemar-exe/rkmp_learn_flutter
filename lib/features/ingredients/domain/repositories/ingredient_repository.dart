import 'package:rkmp_learn_flutter/features/ingredients/domain/entities/ingredient_entity.dart';
abstract class IngredientRepository {
  Future<List<IngredientEntity>> getUserIngredients();

  Future<List<IngredientEntity>> getAvailableIngredients();

  Future<List<IngredientEntity>> searchAvailableIngredientsByName(String query);

  Future<void> addOrUpdateIngredient(IngredientEntity ingredient);

  Future<void> removeIngredient(int ingredientId);

  Future<void> addAmount(int ingredientId, double amount);

  Future<void> consumeAmount(int ingredientId, double amount);
}