import 'package:rkmp_learn_flutter/core/utils/formatters.dart';
import 'package:rkmp_learn_flutter/data/datasources/local/schedule_local_data_source.dart';

import '../../../core/models/ingredient.dart';
import '../../../core/models/recipe.dart';
import '../../../core/models/scheduled_meal.dart';
import '../../../core/models/statistics.dart';
import '../remote/api/ingredients_api_datasource.dart';

class StatisticsLocalDataSource {
  final DriftScheduleLocalDataSource _scheduleDataSource;
  final IngredientsApiDataSource _ingredientsRemoteDataSource;

  StatisticsLocalDataSource(
    this._scheduleDataSource,
    this._ingredientsRemoteDataSource,
  );

  Future<Statistics> calculateStatisticsForThisWeek() async {
    return _calculateStatisticsForWeek(DateTime.now());
  }

  Future<Statistics> calculateStatisticsForLastWeek() async {
    return _calculateStatisticsForWeek(
      DateTime.now().subtract(const Duration(days: 7)),
    );
  }

  Future<Statistics> _calculateStatisticsForWeek(
    DateTime weekStart,
  ) async {
    final startOfLastWeek = _getStartOfWeek(weekStart);
    final endOfLastWeek = startOfLastWeek.add(const Duration(days: 7));

    final schedule = await _scheduleDataSource.getScheduleForWeek(
      startOfLastWeek,
    );

    final eatenMeals = _filterEatenMeals(
      schedule,
      startOfLastWeek,
      endOfLastWeek,
    );

    final recipeCountByDay = _countRecipesByDay(eatenMeals);
    final categoryCount = _countCategories(eatenMeals);
    final ingredientUsageCount = _countIngredientUsage(eatenMeals);

    final mostEatenRecipe = _findMostEatenRecipe(eatenMeals);
    final availableIngredients = await _ingredientsRemoteDataSource
        .getAvailableIngredients();

    final availableIngredientsNames = _extractIngredientNames(
      availableIngredients,
    );

    final suggestedIngredients = _getSuggestedIngredients(
      ingredientUsageCount,
      availableIngredientsNames,
    );

    return Statistics(
      mostEatenRecipeThisWeek: mostEatenRecipe,
      recipeCountByDay: recipeCountByDay,
      categoryCount: categoryCount,
      ingredientUsageCount: ingredientUsageCount,
      suggestedIngredients: suggestedIngredients,
    );
  }

  Set<String> _extractIngredientNames(List<Ingredient> ingredients) {
    return ingredients.map((ing) => ing.name.toLowerCase()).toSet();
  }

  List<ScheduledMeal> _filterEatenMeals(
    List<ScheduledMeal> schedule,
    DateTime startOfLastWeek,
    DateTime endOfLastWeek,
  ) {
    return schedule.where((meal) {
      final isEaten = meal.isEaten;
      final withinRange =
          meal.date.isAfter(
            startOfLastWeek.subtract(const Duration(days: 1)),
          ) &&
          meal.date.isBefore(endOfLastWeek.add(const Duration(days: 1)));
      return isEaten && withinRange;
    }).toList();
  }

  Map<String, int> _countRecipesByDay(List<ScheduledMeal> eatenMeals) {
    final counts = <String, int>{};
    for (final meal in eatenMeals) {
      final dayKey = "${meal.date.year}-${meal.date.month}-${meal.date.day}";
      counts[dayKey] = (counts[dayKey] ?? 0) + 1;
    }
    return counts;
  }

  Map<String, int> _countCategories(List<ScheduledMeal> eatenMeals) {
    final counts = <String, int>{};
    for (final meal in eatenMeals) {
      if (meal.recipe != null) {
        final category = meal.recipe!.category;
        counts[category] = (counts[category] ?? 0) + 1;
      }
    }
    return counts;
  }

  Map<String, int> _countIngredientUsage(List<ScheduledMeal> eatenMeals) {
    final counts = <String, int>{};
    for (final meal in eatenMeals) {
      if (meal.recipe != null) {
        for (final ingredient in meal.recipe!.ingredientsWithMeasure.keys) {
          counts[ingredient] = (counts[ingredient] ?? 0) + 1;
        }
      }
    }
    return counts;
  }

  Recipe? _findMostEatenRecipe(List<ScheduledMeal> eatenMeals) {
    final recipeEatenCount = <int, int>{};
    Recipe? mostEatenRecipe;
    int maxCount = 0;

    for (final meal in eatenMeals) {
      if (meal.recipe != null) {
        final recipeId = meal.recipe!.id;
        recipeEatenCount[recipeId] = (recipeEatenCount[recipeId] ?? 0) + 1;
        if (recipeEatenCount[recipeId]! > maxCount) {
          maxCount = recipeEatenCount[recipeId]!;
          mostEatenRecipe = meal.recipe;
        }
      }
    }

    return mostEatenRecipe;
  }

  List<String> _getSuggestedIngredients(
    Map<String, int> ingredientUsageCount,
    Set<String> availableIngredientsNames,
  ) {

    final suggestedIngredients = availableIngredientsNames
        .where((ing) => !ingredientUsageCount.containsKey(ing))
    .map((ing) => Formatters.capitalizeWords(ing))
        .toList();

    return suggestedIngredients;
  }

  DateTime _getStartOfWeek(DateTime date) {
    final weekday = date.weekday;
    return date.subtract(Duration(days: weekday - 1));
  }

}
