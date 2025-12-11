import '../../../core/models/ingredient.dart';
import '../../database/dao/ingredient_dao.dart';
import '../../database/database.dart';

class DriftIngredientsLocalDataSource {
  final IngredientDao _dao;

  DriftIngredientsLocalDataSource(this._dao);

  Stream<List<Ingredient>> watchUserIngredients() async* {
    await for (final ingredients in _dao.watchAllIngredients()) {
      yield ingredients.map((i) => _mapFromEntity(i)).toList();
    }
  }

  Future<List<Ingredient>> getUserIngredients() async {
    final ingredients = await _dao.getAllIngredients();
    return ingredients.map((i) => _mapFromEntity(i)).toList();
  }

  Future<void> addOrUpdateIngredient(Ingredient ingredient) async {
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

  Ingredient _mapFromEntity(IngredientEntity i) {
    return Ingredient(
      id: i.id,
      name: i.name,
      measureUnit: i.measureUnit,
      amount: i.amount,
    );
  }
}
