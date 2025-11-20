import 'package:rkmp_learn_flutter/features/recipes/domain/entities/recipe_entity.dart';
import 'package:rkmp_learn_flutter/features/schedule/domain/entities/schedule_meal_entity.dart';

class ScheduleLocalDataSource {
  static final List<Map<String, dynamic>> _schedule = [
    {
      'id': 1,
      'date': DateTime(2025, 11, 22).toIso8601String(),
      'mealTime': 'breakfast',
      'recipeId': 1,
      'isEaten': false,
    },
    {
      'id': 2,
      'date': DateTime(2025, 11, 22).toIso8601String(),
      'mealTime': 'lunch',
      'recipeId': 2,
      'isEaten': false,
    },
    {
      'id': 3,
      'date': DateTime(2025, 11, 23).toIso8601String(),
      'mealTime': 'dinner',
      'recipeId': 3,
      'isEaten': false,
    },
  ];

  // Статический список рецептов для симуляции связей
  static final List<RecipeEntity> _recipes = [
    RecipeEntity(
      id: 1,
      name: 'Oatmeal',
      category: 'Breakfast',
      area: 'American',
      instructions: 'Cook oats with milk.',
      imageUrl: 'https://example.com/oatmeal.jpg',
      ingredientsWithMeasure: {'Oats': '1 cup', 'Milk': '200ml'},
    ),
    RecipeEntity(
      id: 2,
      name: 'Chicken Salad',
      category: 'Lunch',
      area: 'American',
      instructions: 'Mix chicken, greens, and dressing.',
      imageUrl: 'https://example.com/chicken_salad.jpg',
      ingredientsWithMeasure: {'Chicken': '100g', 'Lettuce': '50g'},
    ),
    RecipeEntity(
      id: 3,
      name: 'Pasta Primavera',
      category: 'Dinner',
      area: 'Italian',
      instructions: 'Cook pasta and mix with vegetables.',
      imageUrl: 'https://example.com/pasta.jpg',
      ingredientsWithMeasure: {'Pasta': '200g', 'Mixed Veggies': '150g'},
    ),
  ];

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Future<List<ScheduledMealEntity>> getScheduleForWeek(DateTime startDate) async {
    await _simulateDelay();
    final startOfWeek = _getStartOfWeek(startDate);
    final endOfWeek = startOfWeek.add(const Duration(days: 7));

    final weekSchedule = _schedule.where((meal) {
      final mealDate = DateTime.parse(meal['date']);
      final mealDateOnly = DateTime(mealDate.year, mealDate.month, mealDate.day);
      final startOfWeekOnly = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
      final endOfWeekOnly = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day);

      return mealDateOnly.isAtSameMomentAs(startOfWeekOnly) ||
          mealDateOnly.isAfter(startOfWeekOnly) && mealDateOnly.isBefore(endOfWeekOnly);
    }).toList();

    return weekSchedule.map(_mapToEntity).toList();
  }

  Future<ScheduledMealEntity?> getMealForDayAndTime(DateTime date,
      MealTime mealTime,) async {
    await _simulateDelay();
    final dateStr = date.toIso8601String().split('T')[0];
    final meal = _schedule.firstWhere(
          (m) =>
      m['date'].startsWith(dateStr) &&
          m['mealTime'] == _mealTimeToString(mealTime),
      orElse: () => {'null': 'null'},
    );
    return meal.keys.first != 'null' ? _mapToEntity(meal) : null;
  }

  Future<void> upsertMeal(ScheduledMealEntity meal) async {
    await _simulateDelay();
    final dateStr = meal.date.toIso8601String().split('T')[0];
    final mealTimeString = _mealTimeToString(meal.mealTime);

    final index = _schedule.indexWhere((m) =>
    m['date'].startsWith(dateStr) && m['mealTime'] == mealTimeString);

    if (index != -1) {
      _schedule[index] = {
        'id': _schedule[index]['id'],
        'date': meal.date.toIso8601String(),
        'mealTime': mealTimeString,
        'recipeId': meal.recipe?.id,
        'isEaten': false
      };
    } else {
      final newId = _generateNewId();
      _schedule.add({
        'id': newId,
        'date': meal.date.toIso8601String(),
        'mealTime': mealTimeString,
        'recipeId': meal.recipe?.id,
        'isEaten': false
      });
    }
  }

  Future<void> deleteMeal(int mealId) async {
    await _simulateDelay();
    _schedule.removeWhere((m) => m['id'] == mealId);
  }

  Future<void> setMealAsEatenById(int mealId, bool isEaten) async {
    await _simulateDelay();
    final meal = _schedule.firstWhere(
          (m) => m['id'] == mealId,
      orElse: () => throw Exception('Meal not found'),
    );
    meal['isEaten'] = isEaten;
  }

  Future<void> unassignRecipeFromMealById(int mealId) async {
    await _simulateDelay();
    final meal = _schedule.firstWhere(
          (m) => m['id'] == mealId,
      orElse: () => throw Exception('Meal not found'),
    );
    meal['recipeId'] = null;
  }

  int _generateNewId() {
    if (_schedule.isEmpty) return 1;
    final maxId = _schedule
        .map((m) => m['id'] as int)
        .reduce((a, b) => a > b ? a : b);
    return maxId + 1;
  }

  ScheduledMealEntity _mapToEntity(Map<String, dynamic> map) {
    final recipeId = map['recipeId'] as int?;
    final recipe = recipeId != null
        ? _recipes.firstWhere(
          (r) => r.id == recipeId,
      orElse: () =>
          RecipeEntity(
            id: -1,
            name: 'Unknown',
            category: '',
            area: '',
            instructions: '',
            imageUrl: '',
            ingredientsWithMeasure: {},
          ),
    )
        : null;

    return ScheduledMealEntity(
      id: map['id'],
      date: DateTime.parse(map['date']),
      mealTime: _stringToMealTime(map['mealTime']),
      recipe: recipe,
      isEaten: map['isEaten'],
    );
  }

  String _mealTimeToString(MealTime time) {
    switch (time) {
      case MealTime.breakfast:
        return 'breakfast';
      case MealTime.lunch:
        return 'lunch';
      case MealTime.dinner:
        return 'dinner';
    }
  }

  MealTime _stringToMealTime(String time) {
    switch (time) {
      case 'breakfast':
        return MealTime.breakfast;
      case 'lunch':
        return MealTime.lunch;
      case 'dinner':
        return MealTime.dinner;
      default:
        throw ArgumentError('Invalid MealTime string: $time');
    }
  }

  DateTime _getStartOfWeek(DateTime date) {
    final weekday = date.weekday;
    return date.subtract(Duration(days: weekday - 1));
  }
}
