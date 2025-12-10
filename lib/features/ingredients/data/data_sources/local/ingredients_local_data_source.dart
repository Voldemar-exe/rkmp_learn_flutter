import 'package:rkmp_learn_flutter/shared/data/database/dao/ingredient_dao.dart';
import 'package:rkmp_learn_flutter/shared/data/database/database.dart';

import '../../../domain/entities/ingredient_entity.dart';

class IngredientsLocalDataSource {
  final IngredientDao _dao;

  IngredientsLocalDataSource(this._dao);

  Stream<List<IngredientEntity>> watchUserIngredients() async* {
    await for (final ingredients in _dao.watchAllIngredients()) {
      yield ingredients.map((i) => _mapToEntity(i)).toList();
    }
  }

  Future<List<IngredientEntity>> getUserIngredients() async {
    final ingredients = await _dao.getAllIngredients();
    return ingredients.map((i) => _mapToEntity(i)).toList();
  }

  Future<void> addOrUpdateIngredient(IngredientEntity ingredient) async {
    await _dao.insertOrUpdateIngredient(
      ingredient.name,
      ingredient.measureUnit,
      ingredient.amount,
      ingredient.id,
    );
  }

  Future<void> removeIngredient(int ingredientId) async {
    await _dao.deleteIngredient(ingredientId);
  }

  Future<void> addAmount(int ingredientId, double amount) async {
    final current = await _dao.getAllIngredients().then(
      (list) => list.firstWhere(
        (i) => i.id == ingredientId,
        orElse: () => throw Exception('Not found'),
      ),
    );
    await _dao.updateAmount(ingredientId, current.amount + amount);
  }

  Future<void> consumeAmount(int ingredientId, double amount) async {
    await _dao.consumeAmount(ingredientId, amount);
  }

  IngredientEntity _mapToEntity(Ingredient i) {
    return IngredientEntity(
      id: i.id,
      name: i.name,
      measureUnit: i.measureUnit,
      amount: i.amount,
    );
  }
}
