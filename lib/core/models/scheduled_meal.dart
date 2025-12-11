import 'package:rkmp_learn_flutter/core/models/recipe.dart';

enum MealTime { breakfast, lunch, dinner }

class ScheduledMeal {
  final int id;
  final DateTime date;
  final MealTime mealTime;
  final Recipe? recipe;
  final bool isEaten;

  ScheduledMeal({
    required this.id,
    required this.date,
    required this.mealTime,
    this.recipe,
    this.isEaten = false,
  });

  ScheduledMeal copyWith({
    int? id,
    DateTime? date,
    MealTime? mealTime,
    Recipe? recipe,
    bool? isEaten,
  }) {
    return ScheduledMeal(
      id: id ?? this.id,
      date: date ?? this.date,
      mealTime: mealTime ?? this.mealTime,
      recipe: recipe ?? this.recipe,
      isEaten: isEaten ?? this.isEaten,
    );
  }
}