import 'package:rkmp_learn_flutter/features/recipes/domain/entities/recipe_entity.dart';

class Recipe extends RecipeEntity {
  Recipe({
    required super.id,
    required super.name,
    required super.category,
    required super.area,
    required super.instructions,
    required super.imageUrl,
    required super.ingredientsWithMeasure,
  });

  RecipeEntity toEntity() {
    return RecipeEntity(
      id: id,
      name: name,
      category: category,
      area: area,
      instructions: instructions,
      imageUrl: imageUrl,
      ingredientsWithMeasure: ingredientsWithMeasure,
    );
  }

  factory Recipe.fromEntity(RecipeEntity entity) {
    return Recipe(
      id: entity.id,
      name: entity.name,
      category: entity.category,
      area: entity.area,
      instructions: entity.instructions,
      imageUrl: entity.imageUrl,
      ingredientsWithMeasure: entity.ingredientsWithMeasure,
    );
  }
}