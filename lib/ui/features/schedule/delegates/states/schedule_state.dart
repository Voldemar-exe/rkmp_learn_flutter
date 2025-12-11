import '../../../../../core/models/scheduled_meal.dart';

class ScheduleState {
  final List<ScheduledMeal> schedule;
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
    List<ScheduledMeal>? schedule,
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