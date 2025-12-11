import '../../core/models/recipe.dart';
import '../interfaces/repositories/recipe_repository.dart';

class GetUserRecipesUseCase {
  final RecipeRepository _repository;

  GetUserRecipesUseCase(this._repository);

  Future<List<Recipe>> execute() async {
    final recipes = await _repository.getUserRecipes();
    return recipes;
  }
}