

import '../../core/models/ingredient.dart';
import '../../domain/interfaces/repositories/ingredient_repository.dart';
import '../datasources/api/ingredients_api_datasource.dart';
import '../datasources/local/ingredients_local_datasource.dart';

class IngredientRepositoryImpl implements IngredientRepository {
  final DriftIngredientsLocalDataSource _localDataSource;
  final IngredientsApiDataSource _remoteDataSource;


  IngredientRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Stream<List<Ingredient>> watchUserIngredients() {
    return _localDataSource.watchUserIngredients();
  }

  @override
  Future<List<Ingredient>> getUserIngredients() async {
    return await _localDataSource.getUserIngredients();
  }

  @override
  Future<List<Ingredient>> getAvailableIngredients() async {
    return await _remoteDataSource.getAvailableIngredients();
  }

  @override
  Future<List<Ingredient>> searchAvailableIngredientsByName(String query) async {
    return await _remoteDataSource.searchAvailableIngredientsByName(query);
  }

  @override
  Future<void> addOrUpdateIngredient(Ingredient ingredient) async {
    await _localDataSource.addOrUpdateIngredient(ingredient);
  }

  @override
  Future<void> removeIngredient(int ingredientId) async {
    await _localDataSource.removeIngredient(ingredientId);
  }

  @override
  Future<void> addAmount(int ingredientId, double amount) async {
    await _localDataSource.addAmount(ingredientId, amount);
  }

  @override
  Future<void> consumeAmount(int ingredientId, double amount) async {
    await _localDataSource.consumeAmount(ingredientId, amount);
  }
}