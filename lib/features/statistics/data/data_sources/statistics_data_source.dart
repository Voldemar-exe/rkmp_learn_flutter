import 'package:rkmp_learn_flutter/core/utils/formatters.dart';
import 'package:rkmp_learn_flutter/features/ingredients/data/data_sources/remote/ingredients_remote_data_source.dart';
import 'package:rkmp_learn_flutter/features/ingredients/domain/entities/ingredient_entity.dart';
import 'package:rkmp_learn_flutter/features/recipes/domain/entities/recipe_entity.dart';
import 'package:rkmp_learn_flutter/features/schedule/data/data_sources/local/schedule_local_data_source.dart';
import 'package:rkmp_learn_flutter/features/schedule/domain/entities/schedule_meal_entity.dart';
import 'package:rkmp_learn_flutter/features/statistics/domain/entities/statistics_entity.dart';

class StatisticsLocalDataSource {
  final ScheduleLocalDataSource _scheduleDataSource;
  final IngredientsRemoteDataSource _ingredientsRemoteDataSource;

  StatisticsLocalDataSource(
    this._scheduleDataSource,
    this._ingredientsRemoteDataSource,
  );

  Future<StatisticsEntity> calculateStatisticsForThisWeek() async {
    return _calculateStatisticsForWeek(DateTime.now());
  }

  Future<StatisticsEntity> calculateStatisticsForLastWeek() async {
    return _calculateStatisticsForWeek(
      DateTime.now().subtract(const Duration(days: 7)),
    );
  }

  Future<StatisticsEntity> _calculateStatisticsForWeek(
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

    return StatisticsEntity(
      mostEatenRecipeThisWeek: mostEatenRecipe,
      recipeCountByDay: recipeCountByDay,
      categoryCount: categoryCount,
      ingredientUsageCount: ingredientUsageCount,
      suggestedIngredients: suggestedIngredients,
    );
  }

  Set<String> _extractIngredientNames(List<IngredientEntity> ingredients) {
    return ingredients.map((ing) => ing.name.toLowerCase()).toSet();
  }

  List<ScheduledMealEntity> _filterEatenMeals(
    List<ScheduledMealEntity> schedule,
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

  Map<String, int> _countRecipesByDay(List<ScheduledMealEntity> eatenMeals) {
    final counts = <String, int>{};
    for (final meal in eatenMeals) {
      final dayKey = "${meal.date.year}-${meal.date.month}-${meal.date.day}";
      counts[dayKey] = (counts[dayKey] ?? 0) + 1;
    }
    return counts;
  }

  Map<String, int> _countCategories(List<ScheduledMealEntity> eatenMeals) {
    final counts = <String, int>{};
    for (final meal in eatenMeals) {
      if (meal.recipe != null) {
        final category = meal.recipe!.category;
        counts[category] = (counts[category] ?? 0) + 1;
      }
    }
    return counts;
  }

  Map<String, int> _countIngredientUsage(List<ScheduledMealEntity> eatenMeals) {
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

  RecipeEntity? _findMostEatenRecipe(List<ScheduledMealEntity> eatenMeals) {
    final recipeEatenCount = <int, int>{};
    RecipeEntity? mostEatenRecipe;
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
