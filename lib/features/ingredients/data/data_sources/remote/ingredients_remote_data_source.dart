import '../../../domain/entities/ingredient_entity.dart';

class IngredientsRemoteDataSource {

  static final List<Map<String, dynamic>> _availableIngredients = [
    {'id': 1, 'name': 'Chicken Breast', 'measureUnit': 'g'},
    {'id': 2, 'name': 'Rice', 'measureUnit': 'g'},
    {'id': 3, 'name': 'Tomato', 'measureUnit': 'pcs'},
    {'id': 4, 'name': 'Salt', 'measureUnit': 'tsp'},
    {'id': 5, 'name': 'Pepper', 'measureUnit': 'tsp'},
    {'id': 6, 'name': 'Onion', 'measureUnit': 'pcs'},
    {'id': 7, 'name': 'Garlic', 'measureUnit': 'cloves'},
    {'id': 8, 'name': 'Olive Oil', 'measureUnit': 'ml'},
    {'id': 9, 'name': 'Sugar', 'measureUnit': 'g'},
    {'id': 10, 'name': 'Flour', 'measureUnit': 'g'},
    {'id': 11, 'name': 'Eggs', 'measureUnit': 'pcs'},
    {'id': 12, 'name': 'Milk', 'measureUnit': 'ml'},
    {'id': 13, 'name': 'Butter', 'measureUnit': 'g'},
    {'id': 14, 'name': 'Cheese', 'measureUnit': 'g'},
    {'id': 15, 'name': 'Pasta', 'measureUnit': 'g'},
  ];

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Future<List<IngredientEntity>> getAvailableIngredients() async {
    await _simulateDelay();
    return _availableIngredients.map(_mapToEntity).toList();
  }

  Future<List<IngredientEntity>> searchAvailableIngredientsByName(String query) async {
    await _simulateDelay();
    final results = _availableIngredients
        .where((ing) => ing['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();
    return results.map(_mapToEntity).toList();
  }

  IngredientEntity _mapToEntity(Map<String, dynamic> map) {
    return IngredientEntity(
      id: map['id'],
      name: map['name'],
      measureUnit: map['measureUnit'],
    );
  }
}