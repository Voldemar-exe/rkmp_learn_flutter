import 'package:rkmp_learn_flutter/features/recipes/domain/entities/recipe_entity.dart';

abstract class RecipeRepository {
  Future<List<RecipeEntity>> getUserRecipes();
  Future<List<RecipeEntity>> searchUserRecipesByName(String query);
  Future<List<RecipeEntity>> searchRecipesByName(String query);
  Future<RecipeEntity> getRandomRecipe();
  Future<List<RecipeEntity>> getRecipesByIngredients(List<String> ingredients);
  Future<RecipeEntity?> getRecipeById(int id);
  Future<void> saveRecipe(RecipeEntity recipe);
  Future<void> removeRecipe(int recipeId);
}
