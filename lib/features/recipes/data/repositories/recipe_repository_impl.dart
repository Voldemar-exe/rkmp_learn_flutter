import 'package:rkmp_learn_flutter/features/recipes/domain/repositories/recipe_repository.dart';

import '../../domain/entities/recipe_entity.dart';
import '../data_sources/local/recipes_local_data_source.dart';
import '../data_sources/remote/recipes_remote_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipesRemoteDataSource _remoteDataSource;
  final RecipesLocalDataSource _localDataSource;

  RecipeRepositoryImpl({
    required RecipesRemoteDataSource remoteDataSource,
    required RecipesLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<List<RecipeEntity>> getUserRecipes() async {
    return await _localDataSource.getUserRecipes();
  }

  @override
  Future<RecipeEntity?> getRecipeById(int id) async {
    var recipe = await _localDataSource.getRecipeById(id);
    if (recipe != null) return recipe;

    recipe = await _remoteDataSource.getRecipeById(id);
    if (recipe == null) return null;
    return recipe;
  }

  @override
  Future<List<RecipeEntity>> searchRecipesByName(String query) async {
    return await _remoteDataSource.searchRecipesByName(query);
  }

  @override
  Future<List<RecipeEntity>> searchUserRecipesByName(String query) async {
    return await _localDataSource.searchUserRecipesByName(query);
  }

  @override
  Future<RecipeEntity> getRandomRecipe() async {
    return await _remoteDataSource.getRandomRecipe();
  }

  @override
  Future<void> saveRecipe(RecipeEntity recipe) async {
    await _localDataSource.saveRecipe(recipe);
  }

  @override
  Future<void> removeRecipe(int recipeId) async {
    await _localDataSource.removeRecipe(recipeId);
  }

  @override
  Future<List<RecipeEntity>> getRecipesByIngredients(List<String> ingredients) {
    throw UnimplementedError();
  }
}

