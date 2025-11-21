import '../../../domain/entities/recipe_entity.dart';

class RecipesLocalDataSource {
  static final List<Map<String, dynamic>> _localRecipes = [
    {
      'id': 53158,
      'name': 'Air fryer patatas bravas',
      'category': 'Vegetarian',
      'area': 'Spanish',
      'instructions': 'Soak the potatoes in just-boiled water for 30 mins, then drain and leave to air-dry for 5 mins.',
      'imageUrl': 'https://www.themealdb.com/images/media/meals/3m8yae1763257951.jpg',
      'ingredientsWithMeasure': {
        'Potatoes': '900g',
        'Olive Oil': '3  tablespoons',
        'Onion': '1 chopped',
        'Garlic': '1 clove peeled crushed',
        'Paprika': '1 tblsp ',
        'Tomato Puree': '1 tblsp ',
        'Tinned Tomatos': '225g',
        'Basil Leaves': 'To serve',
      },
    },
    {
      'id': 53169,
      'name': 'Ajo blanco',
      'category': 'Starter',
      'area': 'Spanish',
      'instructions': 'Tip the bread into a bowl and pour over 350ml water.',
      'imageUrl': 'https://www.themealdb.com/images/media/meals/5jdtie1763289302.jpg',
      'ingredientsWithMeasure': {
        'White bread': '150g',
        'Almonds': '200g',
        'Extra Virgin Olive Oil': '50 ml ',
        'Garlic Clove': '1',
        'Red Wine Vinegar': '1 ½ tbsp',
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
