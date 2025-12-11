import 'dart:convert';

import '../../../core/models/recipe.dart';
import '../../database/dao/recipe_dao.dart';
import '../../database/database.dart';

class DriftRecipesLocalDataSource {
  final RecipeDao _recipeDao;

  DriftRecipesLocalDataSource(this._recipeDao);

  Future<List<Recipe>> getUserRecipes() async {
    final recipes = await _recipeDao.getAllRecipes();
    return _mapFromEntities(recipes);
  }

  Future<void> saveRecipe(Recipe recipe) async {
    await _recipeDao.insertRecipe(
      id: recipe.id,
      name: recipe.name,
      category: recipe.category,
      area: recipe.area,
      instructions: recipe.instructions,
      imageUrl: recipe.imageUrl,
      ingredientsWithMeasure: recipe.ingredientsWithMeasure,
    );
  }

  Future<List<Recipe>> searchUserRecipesByName(String query) async {
    final recipes = await _recipeDao.searchByName(query);
    return _mapFromEntities(recipes);
  }

  Future<Recipe?> getRecipeById(int id) async {
    final recipe = await _recipeDao.getById(id);
    return recipe != null ? _mapFromEntity(recipe) : null;
  }

  Future<void> removeRecipe(int recipeId) async {
    await _recipeDao.deleteRecipe(recipeId);
  }

  List<Recipe> _mapFromEntities(List<RecipeEntity> entities) {
    return entities.map(_mapFromEntity).toList();
  }

  Recipe _mapFromEntity(RecipeEntity entity) {
    final decoded = jsonDecode(entity.ingredientsWithMeasure) as Map<String, dynamic>;

    final ingredientsWithMeasure = <String, String>{
      for (final entry in decoded.entries)
        entry.key: entry.value as String,
    };

    return Recipe(
      id: entity.id,
      name: entity.name,
      category: entity.category,
      area: entity.area,
      instructions: entity.instructions,
      imageUrl: entity.imageUrl,
      ingredientsWithMeasure: ingredientsWithMeasure,
    );
  }
}
