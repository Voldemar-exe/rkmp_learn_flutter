import '../../../core/models/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getUserRecipes();
  Future<List<Recipe>> searchUserRecipesByName(String query);
  Future<List<Recipe>> searchRecipesByName(String query);
  Future<Recipe> getRandomRecipe();
  Future<List<Recipe>> getRecipesByIngredients(List<String> ingredients);
  Future<Recipe?> getRecipeById(int id);
  Future<void> saveRecipe(Recipe recipe);
  Future<void> removeRecipe(int recipeId);
}
