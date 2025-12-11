import 'package:rkmp_learn_flutter/core/models/recipe.dart';

class Statistics {
  final Recipe? mostEatenRecipeThisWeek;
  final Map<String, int> recipeCountByDay;
  final Map<String, int> categoryCount;
  final Map<String, int> ingredientUsageCount;
  final List<String> suggestedIngredients;

  Statistics({
    this.mostEatenRecipeThisWeek,
    required this.recipeCountByDay,
    required this.categoryCount,
    required this.ingredientUsageCount,
    required this.suggestedIngredients,
  });

  Statistics copyWith({
    Recipe? mostEatenRecipeThisWeek,
    Map<String, int>? recipeCountByDay,
    Map<String, int>? categoryCount,
    Map<String, int>? ingredientUsageCount,
    List<String>? suggestedIngredients,
  }) {
    return Statistics(
      mostEatenRecipeThisWeek:
          mostEatenRecipeThisWeek ?? this.mostEatenRecipeThisWeek,
      recipeCountByDay: recipeCountByDay ?? this.recipeCountByDay,
      categoryCount: categoryCount ?? this.categoryCount,
      ingredientUsageCount: ingredientUsageCount ?? this.ingredientUsageCount,
      suggestedIngredients: suggestedIngredients ?? this.suggestedIngredients,
    );
  }
}
