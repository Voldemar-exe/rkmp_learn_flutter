import 'package:rkmp_learn_flutter/features/recipes/domain/entities/recipe_entity.dart';

class StatisticsEntity {
  final RecipeEntity? mostEatenRecipeThisWeek;
  final Map<String, int> recipeCountByDay;
  final Map<String, int> categoryCount;
  final Map<String, int> ingredientUsageCount;
  final List<String> suggestedIngredients;

  StatisticsEntity({
    this.mostEatenRecipeThisWeek,
    required this.recipeCountByDay,
    required this.categoryCount,
    required this.ingredientUsageCount,
    required this.suggestedIngredients,
  });

  StatisticsEntity copyWith({
    RecipeEntity? mostEatenRecipeThisWeek,
    Map<String, int>? recipeCountByDay,
    Map<String, int>? categoryCount,
    Map<String, int>? ingredientUsageCount,
    List<String>? suggestedIngredients,
  }) {
    return StatisticsEntity(
      mostEatenRecipeThisWeek: mostEatenRecipeThisWeek ?? this.mostEatenRecipeThisWeek,
      recipeCountByDay: recipeCountByDay ?? this.recipeCountByDay,
      categoryCount: categoryCount ?? this.categoryCount,
      ingredientUsageCount: ingredientUsageCount ?? this.ingredientUsageCount,
      suggestedIngredients: suggestedIngredients ?? this.suggestedIngredients,
    );
  }

  factory StatisticsEntity.fromJson(Map<String, dynamic> json) {
    return StatisticsEntity(
      mostEatenRecipeThisWeek: json['mostEatenRecipeThisWeek'] != null
          ? RecipeEntity.fromJson(json['mostEatenRecipeThisWeek'])
          : null,
      recipeCountByDay: Map<String, int>.from(json['recipeCountByDay']),
      categoryCount: Map<String, int>.from(json['categoryCount']),
      ingredientUsageCount: Map<String, int>.from(json['ingredientUsageCount']),
      suggestedIngredients: List<String>.from(json['suggestedIngredients']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mostEatenRecipeThisWeek': mostEatenRecipeThisWeek?.toJson(),
      'recipeCountByDay': recipeCountByDay,
      'categoryCount': categoryCount,
      'ingredientUsageCount': ingredientUsageCount,
      'suggestedIngredients': suggestedIngredients,
    };
  }
}