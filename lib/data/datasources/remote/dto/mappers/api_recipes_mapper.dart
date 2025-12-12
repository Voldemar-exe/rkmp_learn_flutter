import '../../../../../core/models/recipe.dart';
import '../api_recipes_dto.dart';

extension ApiRecipesMapper on ApiRecipesDto {
  Recipe dtoToRecipe() {
    return Recipe(
      id: id,
      name: name,
      category: category,
      area: area,
      instructions: instructions,
      imageUrl: imageUrl,
      ingredientsWithMeasure: ingredientsWithMeasure,
    );
  }
}

extension RecipeToApiMapper on Recipe {
  ApiRecipesDto recipeToDto() {
    return ApiRecipesDto(
      id: id,
      name: name,
      category: category,
      area: area,
      instructions: instructions,
      imageUrl: imageUrl,
      ingredientsWithMeasure: ingredientsWithMeasure,
    );
  }
}
