import '../../core/models/recipe.dart';
import '../../domain/interfaces/repositories/recipe_repository.dart';
import '../datasources/api/recipes_api_datasource.dart';
import '../datasources/local/recipes_local_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipesApiDataSource _remoteDataSource;
  final DriftRecipesLocalDataSource _localDataSource;

  RecipeRepositoryImpl({
    required RecipesApiDataSource remoteDataSource,
    required DriftRecipesLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<List<Recipe>> getUserRecipes() async {
    return await _localDataSource.getUserRecipes();
  }

  @override
  Future<Recipe?> getRecipeById(int id) async {
    var recipe = await _localDataSource.getRecipeById(id);
    if (recipe != null) return recipe;

    recipe = await _remoteDataSource.getRecipeById(id);
    if (recipe == null) return null;
    return recipe;
  }

  @override
  Future<List<Recipe>> searchRecipesByName(String query) async {
    return await _remoteDataSource.searchRecipesByName(query);
  }

  @override
  Future<List<Recipe>> searchUserRecipesByName(String query) async {
    return await _localDataSource.searchUserRecipesByName(query);
  }

  @override
  Future<Recipe> getRandomRecipe() async {
    return await _remoteDataSource.getRandomRecipe();
  }

  @override
  Future<void> saveRecipe(Recipe recipe) async {
    await _localDataSource.saveRecipe(recipe);
  }

  @override
  Future<void> removeRecipe(int recipeId) async {
    await _localDataSource.removeRecipe(recipeId);
  }

  @override
  Future<List<Recipe>> getRecipesByIngredients(List<String> ingredients) {
    throw UnimplementedError();
  }
}

