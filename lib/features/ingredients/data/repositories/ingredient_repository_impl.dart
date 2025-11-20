import 'package:rkmp_learn_flutter/features/ingredients/data/data_sources/local/ingredients_local_data_source.dart';
import 'package:rkmp_learn_flutter/features/ingredients/data/data_sources/remote/ingredients_remote_data_source.dart';
import 'package:rkmp_learn_flutter/features/ingredients/domain/entities/ingredient_entity.dart';
import 'package:rkmp_learn_flutter/features/ingredients/domain/repositories/ingredient_repository.dart';

class IngredientRepositoryImpl implements IngredientRepository {
  final IngredientsLocalDataSource _localDataSource;
  final IngredientsRemoteDataSource _remoteDataSource;


  IngredientRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<List<IngredientEntity>> getUserIngredients() async {
    return await _localDataSource.getUserIngredients();
  }

  @override
  Future<List<IngredientEntity>> getAvailableIngredients() async {
    return await _remoteDataSource.getAvailableIngredients();
  }

  @override
  Future<List<IngredientEntity>> searchAvailableIngredientsByName(String query) async {
    return await _remoteDataSource.searchAvailableIngredientsByName(query);
  }

  @override
  Future<void> addOrUpdateIngredient(IngredientEntity ingredient) async {
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