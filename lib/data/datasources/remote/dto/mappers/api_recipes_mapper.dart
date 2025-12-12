import '../../../../../core/models/recipe.dart';
import '../api_recipe_dto.dart';

extension ApiRecipesMapper on ApiRecipeDto {
  Recipe toModel() {
    return Recipe(
      id: int.tryParse(idMeal ?? '0') ?? 0,
      name: strMeal ?? 'Unknown',
      category: strCategory ?? 'Unknown',
      area: strArea ?? 'Unknown',
      instructions: strInstructions ?? '',
      imageUrl: strMealThumb ?? '',
      ingredientsWithMeasure: getIngredientsWithMeasure(),
    );
  }
}
