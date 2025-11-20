

import '../../../domain/entities/ingredient_entity.dart';

class IngredientsLocalDataSource {
  static final List<Map<String, dynamic>> _localIngredients = [
    {'id': 1, 'name': 'Chicken Breast', 'measureUnit': 'g', 'amount': 500.0},
    {'id': 2, 'name': 'Rice', 'measureUnit': 'g', 'amount': 1000.0},
    {'id': 3, 'name': 'Tomato', 'measureUnit': 'pcs', 'amount': 5.0},
    {'id': 4, 'name': 'Salt', 'measureUnit': 'tsp', 'amount': 10.0},
  ];

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Future<List<IngredientEntity>> getUserIngredients() async {
    await _simulateDelay();
    return _localIngredients.map(_mapToEntity).toList();
  }

  Future<void> addOrUpdateIngredient(IngredientEntity ingredient) async {
    await _simulateDelay();
    final index = _localIngredients.indexWhere(
      (ing) => ing['id'] == ingredient.id,
    );
    if (index != -1) {
      _localIngredients[index] = {
        'id': ingredient.id,
        'name': ingredient.name,
        'measureUnit': ingredient.measureUnit,
        'amount': ingredient.amount,
      };
    } else {
      _localIngredients.add({
        'id': ingredient.id,
        'name': ingredient.name,
        'measureUnit': ingredient.measureUnit,
        'amount': ingredient.amount,
      });
    }
  }

  Future<void> removeIngredient(int ingredientId) async {
    await _simulateDelay();
    _localIngredients.removeWhere((ing) => ing['id'] == ingredientId);
  }

  Future<void> addAmount(int ingredientId, double amount) async {
    await _simulateDelay();
    final ingredient = _localIngredients.firstWhere(
      (ing) => ing['id'] == ingredientId,
      orElse: () => throw Exception('Ingredient not found'),
    );
    ingredient['amount'] = (ingredient['amount'] as double) + amount;
  }

  Future<void> consumeAmount(int ingredientId, double amount) async {
    await _simulateDelay();
    final ingredient = _localIngredients.firstWhere(
      (ing) => ing['id'] == ingredientId,
      orElse: () => throw Exception('Ingredient not found'),
    );
    final currentAmount = ingredient['amount'] as double;
    final newAmount = currentAmount - amount;
    if (newAmount < 0) {
      ingredient['amount'] = 0.0;
    } else {
      ingredient['amount'] = newAmount;
    }
  }

  IngredientEntity _mapToEntity(Map<String, dynamic> map) {
    return IngredientEntity(
      id: map['id'] as int,
      name: map['name'] as String,
      measureUnit: map['measureUnit'] as String?,
      amount: map['amount'] as double?,
    );
  }
}
