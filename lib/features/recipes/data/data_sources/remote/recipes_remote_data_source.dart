import 'dart:math';
import '../../../domain/entities/recipe_entity.dart';

class RecipesRemoteDataSource {
  static final List<Map<String, dynamic>> _apiRecipes = [
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
    {
      'id': 53138,
      'name': 'Alfajores',
      'category': 'Dessert',
      'area': 'Argentinian',
      'instructions': 'Make the Dough: Cream butter and sugar.',
      'imageUrl': 'https://www.themealdb.com/images/media/meals/a4kgf21763075288.jpg',
      'ingredientsWithMeasure': {
        'All purpose flour': '300g',
        'Cornstarch': '200g',
        'Butter': '200g',
        'Sugar': '100g ',
        'Egg Yolks': '2',
        'Lemon Zest': '1 teaspoon',
        'Dulce de leche': ' ',
        'Desiccated Coconut': 'Sprinkling',
      },
    },
    {
      'id': 53111,
      'name': 'Anzac biscuits',
      'category': 'Dessert',
      'area': 'Australian',
      'instructions': 'Heat oven to 180C/fan 160C/gas 4.',
      'imageUrl': 'https://www.themealdb.com/images/media/meals/q47rkb1762324620.jpg',
      'ingredientsWithMeasure': {
        'Porridge oats': '85g',
        'Desiccated Coconut': '85g',
        'Plain Flour': '100g ',
        'Caster Sugar': '100g ',
        'Butter': '100g ',
        'Golden Syrup': '1 tblsp ',
        'Bicarbonate Of Soda': '1 teaspoon',
      },
    },
    {
      'id': 53049,
      'name': 'Apam balik',
      'category': 'Dessert',
      'area': 'Malaysian',
      'instructions': 'Mix milk, oil and egg together.',
      'imageUrl': 'https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg',
      'ingredientsWithMeasure': {
        'Milk': '200ml',
        'Oil': '60ml',
        'Eggs': '2',
        'Flour': '1600g',
        'Baking Powder': '3 tsp',
        'Salt': '1/2 tsp',
        'Unsalted Butter': '25g',
        'Sugar': '45g',
        'Peanut Butter': '3 tbs',
      },
    },
  ];

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<List<RecipeEntity>> getRecipesByUserId(int userId) async {
    await _simulateDelay();
    final userRecipes = _apiRecipes
        .where((r) => r['userId'] == userId)
        .toList();
    return userRecipes.map(_mapToEntity).toList();
  }

  Future<RecipeEntity?> getRecipeById(int id) async {
    await _simulateDelay();
    final recipe = _apiRecipes.firstWhere(
      (r) => r['id'] == id,
      orElse: () => {'null': 'null'},
    );
    if (recipe.keys.first == 'null') return null;
    return _mapToEntity(recipe);
  }

  Future<List<RecipeEntity>> searchRecipesByName(String query) async {
    await _simulateDelay();
    final results = _apiRecipes
        .where((r) => r['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();
    return results.map(_mapToEntity).toList();
  }

  Future<RecipeEntity> getRandomRecipe() async {
    await _simulateDelay();

    final random = Random();
    final randomRecipe = _apiRecipes[random.nextInt(_apiRecipes.length)];
    return _mapToEntity(randomRecipe);
  }

  Future<List<RecipeEntity>> getRecipesByIngredients(
    List<String> ingredients,
  ) async {
    await _simulateDelay();
    return _apiRecipes
        .where(
          (r) => ingredients.any(
            (i) => r['ingredientsWithMeasure'].containsKey(i),
          ),
        )
        .map(_mapToEntity)
        .toList();
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
