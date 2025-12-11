import '../../../core/models/ingredient.dart';

abstract class IngredientRepository {
  Stream<List<Ingredient>> watchUserIngredients();

  Future<List<Ingredient>> getUserIngredients();

  Future<List<Ingredient>> getAvailableIngredients();

  Future<List<Ingredient>> searchAvailableIngredientsByName(String query);

  Future<void> addOrUpdateIngredient(Ingredient ingredient);

  Future<void> removeIngredient(int ingredientId);

  Future<void> addAmount(int ingredientId, double amount);

  Future<void> consumeAmount(int ingredientId, double amount);
}
