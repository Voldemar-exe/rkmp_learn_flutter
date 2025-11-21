import 'package:rkmp_learn_flutter/features/statistics/domain/entities/statistics_entity.dart';

class Statistics extends StatisticsEntity {
  Statistics({
    required super.mostEatenRecipeThisWeek,
    required super.recipeCountByDay,
    required super.categoryCount,
    required super.ingredientUsageCount,
    required super.suggestedIngredients,
  });

  StatisticsEntity toEntity() {
    return StatisticsEntity(
      mostEatenRecipeThisWeek: mostEatenRecipeThisWeek,
      recipeCountByDay: recipeCountByDay,
      categoryCount: categoryCount,
      ingredientUsageCount: ingredientUsageCount,
      suggestedIngredients: suggestedIngredients,
    );
  }

  factory Statistics.fromEntity(StatisticsEntity entity) {
    return Statistics(
      mostEatenRecipeThisWeek: entity.mostEatenRecipeThisWeek,
      recipeCountByDay: entity.recipeCountByDay,
      categoryCount: entity.categoryCount,
      ingredientUsageCount: entity.ingredientUsageCount,
      suggestedIngredients: entity.suggestedIngredients,
    );
  }
}