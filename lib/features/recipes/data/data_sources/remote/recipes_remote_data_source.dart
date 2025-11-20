import 'dart:math';
import '../../../domain/entities/recipe_entity.dart';

class RecipesRemoteDataSource {
  static final List<Map<String, dynamic>> _apiRecipes = [
    {
      'id': 1,
      'name': 'Spaghetti Carbonara',
      'category': 'Pasta',
      'area': 'Italian',
      'instructions': 'Cook pasta. Mix eggs, cheese, and pancetta. Combine.',
      'imageUrl': 'https://example.com/carbonara.jpg',
      'ingredientsWithMeasure': {
        'Spaghetti': '400g',
        'Eggs': '3',
        'Parmesan Cheese': '100g',
        'Pancetta': '150g',
      },
    },
    {
      'id': 2,
      'name': 'Chicken Curry',
      'category': 'Curry',
      'area': 'Indian',
      'instructions': 'Sauté chicken. Add spices and coconut milk. Simmer.',
      'imageUrl': 'https://example.com/chicken_curry.jpg',
      'ingredientsWithMeasure': {
        'Chicken Breast': '500g',
        'Curry Powder': '2 tbsp',
        'Coconut Milk': '400ml',
        'Onion': '1 large',
      },
    },
    {
      'id': 3,
      'name': 'Beef Burger',
      'category': 'Sandwich',
      'area': 'American',
      'instructions': 'Form beef patties. Grill. Add toppings to bun.',
      'imageUrl': 'https://example.com/burger.jpg',
      'ingredientsWithMeasure': {
        'Ground Beef': '300g',
        'Burger Buns': '2',
        'Lettuce': '2 leaves',
        'Tomato': '1 slice',
      },
    },
    {
      'id': 4,
      'name': 'Caesar Salad',
      'category': 'Salad',
      'area': 'American',
      'instructions': 'Chop lettuce. Add dressing and croutons. Toss.',
      'imageUrl': 'https://example.com/caesar_salad.jpg',
      'ingredientsWithMeasure': {
        'Romaine Lettuce': '1 head',
        'Caesar Dressing': '4 tbsp',
        'Croutons': '1 cup',
        'Parmesan': '50g',
      },
    },
    {
      'id': 5,
      'name': 'Sushi Roll',
      'category': 'Seafood',
      'area': 'Japanese',
      'instructions': 'Prepare sushi rice. Lay nori. Add fillings. Roll. Cut.',
      'imageUrl': 'https://example.com/sushi.jpg',
      'ingredientsWithMeasure': {
        'Sushi Rice': '200g',
        'Nori Sheets': '2',
        'Salmon': '100g',
        'Cucumber': '1/2',
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
