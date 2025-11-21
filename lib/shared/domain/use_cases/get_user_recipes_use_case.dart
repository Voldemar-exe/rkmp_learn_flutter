import 'package:rkmp_learn_flutter/features/recipes/data/models/recipe.dart';
import 'package:rkmp_learn_flutter/features/recipes/domain/repositories/recipe_repository.dart';

class GetUserRecipesUseCase {
  final RecipeRepository _repository;

  GetUserRecipesUseCase(this._repository);

  Future<List<Recipe>> call() async {
    final recipes = await _repository.getUserRecipes();
    return recipes
        .map((recipe) => Recipe.fromEntity(recipe))
        .toList();
  }
}