import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/scheduled_meal.dart';
import '../delegates/schedule_view_model.dart';
import '../widgets/meal_tile.dart';

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(scheduleViewModelProvider);

    return asyncState.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, _) => Scaffold(
        appBar: AppBar(title: Text('Расписание')),
        body: Center(child: Text('Error: $err')),
      ),
      data: (state) {
        if (state.error != null) {
          return Scaffold(
            appBar: AppBar(title: Text('Расписание')),
            body: Center(child: Text('Error: ${state.error}')),
          );
        }

        final weekDates = _getWeekDates(state.currentWeekStart);
        final weekScheduleMap = _buildScheduleMap(state.schedule);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              '${weekDates.first.formattedDate} - ${weekDates.last.formattedDate}',
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => ref
                    .read(scheduleViewModelProvider.notifier)
                    .navigateToPreviousWeek(),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => ref
                    .read(scheduleViewModelProvider.notifier)
                    .navigateToNextWeek(),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => ref
                    .read(scheduleViewModelProvider.notifier)
                    .loadScheduleForWeek(state.currentWeekStart),
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) {
              final dayDate = weekDates[index].startOfDay;
              final dayMeals = weekScheduleMap[dayDate] ?? {};

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${dayDate.dayName}, ${dayDate.formattedDate}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    for (final time in MealTime.values)
                      MealTile(
                        mealTime: time,
                        meal: dayMeals[time],
                        onTap: () => context.push(
                          '/home/schedule/select_recipe',
                          extra: {'date': dayDate, 'mealTime': time},
                        ),
                        onActionSelected: (value) {
                          final viewModel = ref.read(
                            scheduleViewModelProvider.notifier,
                          );
                          final meal = dayMeals[time];
                          if (meal == null) return;

                          switch (value) {
                            case 'unassign':
                              viewModel.unassignRecipeFromMeal(meal.id);
                            case 'mark_eaten':
                              viewModel.setMealAsEaten(meal.id, true);
                            case 'mark_not_eaten':
                              viewModel.setMealAsEaten(meal.id, false);
                          }
                        },
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Map<DateTime, Map<MealTime, ScheduledMeal>> _buildScheduleMap(
    List<ScheduledMeal> meals,
  ) {
    final map = <DateTime, Map<MealTime, ScheduledMeal>>{};
    for (final meal in meals) {
      final date = meal.date.startOfDay;
      map.putIfAbsent(date, () => {});
      map[date]![meal.mealTime] = meal;
    }
    return map;
  }

  List<DateTime> _getWeekDates(DateTime startOfWeek) {
    return List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
  }
}

extension DateTimeX on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);

  String get formattedDate =>
      "${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.$year";

  String get dayName {
    switch (weekday) {
      case 1:
        return 'Понедельник';
      case 2:
        return 'Вторник';
      case 3:
        return 'Среда';
      case 4:
        return 'Четверг';
      case 5:
        return 'Пятница';
      case 6:
        return 'Суббота';
      case 7:
        return 'Воскресенье';
      default:
        return '';
    }
  }
}
