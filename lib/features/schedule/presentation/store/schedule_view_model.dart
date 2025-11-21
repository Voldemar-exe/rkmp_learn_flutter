import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/features/recipes/data/models/recipe.dart';
import 'package:rkmp_learn_flutter/features/schedule/data/data_sources/local/schedule_local_data_source.dart';
import 'package:rkmp_learn_flutter/features/schedule/domain/entities/schedule_meal_entity.dart';
import 'package:rkmp_learn_flutter/features/schedule/presentation/states/schedule_state.dart';

part 'schedule_view_model.g.dart';

@riverpod
class ScheduleViewModel extends _$ScheduleViewModel {
  late final ScheduleLocalDataSource _repository;

  @override
  Future<ScheduleState> build() async {
    _repository = GetIt.I<ScheduleLocalDataSource>();
    final now = DateTime.now();
    final startOfWeek = _getStartOfWeek(now);
    try {
      final schedule = await _repository.getScheduleForWeek(startOfWeek);
      return ScheduleState(
        schedule: schedule,
        currentWeekStart: startOfWeek,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      return ScheduleState(
        schedule: [],
        currentWeekStart: startOfWeek,
        isLoading: false,
        error: 'Failed to load schedule',
      );
    }
  }

  Future<void> loadScheduleForWeek(DateTime startDate) async {
    _updateState(isLoading: true, error: null);
    try {
      final schedule = await _repository.getScheduleForWeek(startDate);
      _updateState(
        schedule: schedule,
        currentWeekStart: startDate,
        isLoading: false,
      );
    } catch (e) {
      _updateState(error: 'Failed to load schedule', isLoading: false);
    }
  }

  Future<void> assignRecipeToMeal(
    DateTime date,
    MealTime mealTime,
    Recipe recipe,
  ) async {
    try {
      var existingMeal = await _repository.getMealForDayAndTime(date, mealTime);
      if (existingMeal != null) {
        await _repository.upsertMeal(
          existingMeal.copyWith(recipe: recipe, date: date, mealTime: mealTime),
        );
      } else {
        final newMeal = ScheduledMealEntity(
          id: DateTime.now().millisecondsSinceEpoch,
          date: date,
          mealTime: mealTime,
          recipe: recipe,
        );
        await _repository.upsertMeal(newMeal);
      }
      await loadScheduleForWeek(state.value!.currentWeekStart);
    } catch (e) {
      _updateState(error: 'Failed to assign recipe');
    }
  }

  Future<void> setMealAsEaten(int mealId, bool isEaten) async {
    try {
      await _repository.setMealAsEatenById(mealId, isEaten);
      await loadScheduleForWeek(state.value!.currentWeekStart);
    } catch (e) {
      _updateState(error: 'Failed to update meal status');
    }
  }

  Future<void> unassignRecipeFromMeal(int mealId) async {
    try {
      await _repository.unassignRecipeFromMealById(mealId);
      await loadScheduleForWeek(state.value!.currentWeekStart);
    } catch (e) {
      _updateState(error: 'Failed to unassign recipe');
    }
  }

  void navigateToPreviousWeek() {
    final newStart = state.value!.currentWeekStart.subtract(
      const Duration(days: 7),
    );
    loadScheduleForWeek(newStart);
  }

  void navigateToNextWeek() {
    final newStart = state.value!.currentWeekStart.add(const Duration(days: 7));
    loadScheduleForWeek(newStart);
  }

  void _updateState({
    List<ScheduledMealEntity>? schedule,
    DateTime? currentWeekStart,
    bool? isLoading,
    String? error,
  }) {
    state = AsyncValue.data(
      state.value!.copyWith(
        schedule: schedule ?? state.value!.schedule,
        currentWeekStart: currentWeekStart ?? state.value!.currentWeekStart,
        isLoading: isLoading ?? state.value!.isLoading,
        error: error,
      ),
    );
  }

  DateTime _getStartOfWeek(DateTime date) {
    final weekday = date.weekday;
    return date.subtract(Duration(days: weekday - 1));
  }
}
