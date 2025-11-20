import '../../../domain/entities/recipe_entity.dart';

class RecipesLocalDataSource {
  static final List<Map<String, dynamic>> _localRecipes = [
    {
      'id': 101,
      'name': 'My Custom Recipe',
      'category': 'Dessert',
      'area': 'Home',
      'instructions': 'Mix ingredients. Bake for 30 min.',
      'imageUrl': 'https://example.com/custom_recipe.jpg',
      'ingredientsWithMeasure': {
        'Flour': '200g',
        'Sugar': '100g',
        'Butter': '100g',
        'Eggs': '2',
      },
    },
    {
      'id': 102,
      'name': 'Another Local Dish',
      'category': 'Main',
      'area': 'Home',
      'instructions': 'Stir fry everything together.',
      'imageUrl': 'https://example.com/local_dish.jpg',
      'ingredientsWithMeasure': {
        'Rice': '300g',
        'Mixed Vegetables': '200g',
        'Soy Sauce': '2 tbsp',
        'Garlic': '2 cloves',
      },
    },
  ];

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 150));
  }

  Future<List<RecipeEntity>> getUserRecipes() async {
    await _simulateDelay();
    return _localRecipes.map(_mapToEntity).toList();
  }

  Future<void> saveRecipe(RecipeEntity recipe) async {
    await _simulateDelay();
    _localRecipes.add({
      'id': recipe.id,
      'name': recipe.name,
      'category': recipe.category,
      'area': recipe.area,
      'instructions': recipe.instructions,
      'imageUrl': recipe.imageUrl,
      'ingredientsWithMeasure': recipe.ingredientsWithMeasure,
    });
  }

  Future<List<RecipeEntity>> searchUserRecipesByName(String query) async {
    await _simulateDelay();
    return _localRecipes
        .where(
          (r) => r['name'].toLowerCase().contains(query.toLowerCase()),
        )
        .map(_mapToEntity)
        .toList();
  }

  Future<List<RecipeEntity>> getRecipesByIngredients(
    List<String> ingredients,
  ) async {
    await _simulateDelay();
    return _localRecipes
        .where(
          (r) => ingredients.any(
            (i) => r['ingredientsWithMeasure'].containsKey(i),
          ),
        )
        .map(_mapToEntity)
        .toList();
  }

  Future<RecipeEntity?> getRecipeById(int id) async {
    await _simulateDelay();
    final recipe = _localRecipes.firstWhere(
      (r) => r['id'] == id,
      orElse: () => {'null': 'null'},
    );
    if (recipe.keys.first == 'null') return null;
    return _mapToEntity(recipe);
  }

  Future<void> removeRecipe(int recipeId) async {
    await _simulateDelay();
    _localRecipes.removeWhere((r) => r['id'] == recipeId);
  }

  RecipeEntity _mapToEntity(Map<String, dynamic> map) {
    return RecipeEntity(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      area: map['area'],
      instructions: map['instructions'],
      imageUrl: map['imageUrl'],
      ingredientsWithMeasure: Map<String, String>.from(
        map['ingredientsWithMeasure'],
      ),
    );
  }
}
