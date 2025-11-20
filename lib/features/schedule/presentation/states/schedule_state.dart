import 'package:rkmp_learn_flutter/features/schedule/domain/entities/schedule_meal_entity.dart';

class ScheduleState {
  final List<ScheduledMealEntity> schedule;
  final DateTime currentWeekStart;
  final bool isLoading;
  final String? error;

  ScheduleState({
    required this.schedule,
    required this.currentWeekStart,
    required this.isLoading,
    this.error,
  });

  ScheduleState copyWith({
    List<ScheduledMealEntity>? schedule,
    DateTime? currentWeekStart,
    bool? isLoading,
    String? error,
  }) {
    return ScheduleState(
      schedule: schedule ?? this.schedule,
      currentWeekStart: currentWeekStart ?? this.currentWeekStart,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}