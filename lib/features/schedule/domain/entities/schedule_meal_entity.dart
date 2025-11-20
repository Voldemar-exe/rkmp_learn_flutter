import 'package:rkmp_learn_flutter/features/recipes/domain/entities/recipe_entity.dart';

enum MealTime { breakfast, lunch, dinner }

class ScheduledMealEntity {
  final int id;
  final DateTime date;
  final MealTime mealTime;
  final RecipeEntity? recipe;
  final bool isEaten;

  ScheduledMealEntity({
    required this.id,
    required this.date,
    required this.mealTime,
    this.recipe,
    this.isEaten = false,
  });

  ScheduledMealEntity copyWith({
    int? id,
    DateTime? date,
    MealTime? mealTime,
    RecipeEntity? recipe,
    bool? isEaten,
  }) {
    return ScheduledMealEntity(
      id: id ?? this.id,
      date: date ?? this.date,
      mealTime: mealTime ?? this.mealTime,
      recipe: recipe ?? this.recipe,
      isEaten: isEaten ?? this.isEaten,
    );
  }
}