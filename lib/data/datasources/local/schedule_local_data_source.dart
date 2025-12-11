import 'dart:convert';

import '../../../core/models/recipe.dart';
import '../../../core/models/scheduled_meal.dart';
import '../../database/dao/recipe_dao.dart';
import '../../database/dao/schedule_dao.dart';
import '../../database/database.dart';

class DriftScheduleLocalDataSource {
  final ScheduleDao _scheduleDao;
  final RecipeDao _recipeDao;

  DriftScheduleLocalDataSource({
    required ScheduleDao scheduleDao,
    required RecipeDao recipeDao,
  }) : _scheduleDao = scheduleDao,
       _recipeDao = recipeDao;

  Future<List<ScheduledMeal>> getScheduleForWeek(DateTime startDate) async {
    final scheduleDataList = await _scheduleDao.getScheduleForWeek(startDate);
    return Future.wait(scheduleDataList.map(_mapFromEntity));
  }

  Future<ScheduledMeal?> getMealForDayAndTime(
    DateTime date,
    MealTime mealTime,
  ) async {
    final data = await _scheduleDao.getMealForDayAndTime(
      date,
      mealTime.toString(),
    );
    return data != null ? await _mapFromEntity(data) : null;
  }

  Future<void> upsertMeal(ScheduledMeal meal) async {
    await _scheduleDao.upsertMeal(
      id: meal.id,
      date: meal.date,
      mealTime: meal.mealTime,
      recipeId: meal.recipe?.id,
      isEaten: meal.isEaten,
    );
  }

  Future<void> deleteMeal(int mealId) async {
    await _scheduleDao.deleteMeal(mealId);
  }

  Future<void> setMealAsEatenById(int mealId, bool isEaten) async {
    await _scheduleDao.setMealAsEaten(mealId, isEaten);
  }

  Future<void> unassignRecipeFromMealById(int mealId) async {
    await _scheduleDao.unassignRecipeFromMeal(mealId);
  }

  Future<ScheduledMeal> _mapFromEntity(ScheduleData data) async {
    Recipe? recipe;
    if (data.recipeId != null) {
      final recipeEntity = await _recipeDao.getById(data.recipeId!);
      if (recipeEntity != null) {
        final decoded =
            jsonDecode(recipeEntity.ingredientsWithMeasure)
                as Map<String, dynamic>;
        final ingredientsWithMeasure = <String, String>{
          for (final entry in decoded.entries) entry.key: entry.value as String,
        };
        recipe = Recipe(
          id: recipeEntity.id,
          name: recipeEntity.name,
          category: recipeEntity.category,
          area: recipeEntity.area,
          instructions: recipeEntity.instructions,
          imageUrl: recipeEntity.imageUrl,
          ingredientsWithMeasure: ingredientsWithMeasure,
        );
      }
    }

    final dateTime = DateTime.parse('${data.date}T00:00:00Z');

    return ScheduledMeal(
      id: data.id,
      date: dateTime,
      mealTime: MealTime.values.firstWhere(
        (e) => e.toString() == data.mealTime,
      ),
      recipe: recipe,
      isEaten: data.isEaten,
    );
  }
}
