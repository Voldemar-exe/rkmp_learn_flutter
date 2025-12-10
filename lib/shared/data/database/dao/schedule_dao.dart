import 'package:drift/drift.dart';
import 'package:rkmp_learn_flutter/shared/data/database/database.dart';
import 'package:rkmp_learn_flutter/shared/data/database/tables/schedule_table.dart';

part 'schedule_dao.g.dart';

@DriftAccessor(tables: [Schedule])
class ScheduleDao extends DatabaseAccessor<AppDatabase>
    with _$ScheduleDaoMixin {
  ScheduleDao(super.db);

  Future<List<ScheduleData>> getScheduleForWeek(DateTime startDate) async {
    final startOfWeek = _getStartOfWeek(startDate);
    final endOfWeek = startOfWeek.add(const Duration(days: 7));

    final startStr = startOfWeek.toIso8601String().split('T')[0];
    final endStr = endOfWeek.toIso8601String().split('T')[0];

    return (select(schedule)
      ..where((tbl) =>
      tbl.date.isBiggerOrEqualValue(startStr) &
      tbl.date.isSmallerOrEqualValue(endStr)))
        .get();
  }

  Future<ScheduleData?> getMealForDayAndTime(DateTime date, String mealTime) {
    final dateStr = date.toIso8601String().split('T')[0];
    return (select(schedule)..where((tbl) {
          final dateCol = tbl.date;
          return dateCol.like('$dateStr%') & tbl.mealTime.equals(mealTime);
        }))
        .getSingleOrNull();
  }

  Future<int> upsertMeal(ScheduleCompanion meal) {
    return into(schedule).insertOnConflictUpdate(meal);
  }

  Future<void> deleteMeal(int id) {
    return (delete(schedule)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> setMealAsEaten(int id, bool isEaten) {
    return (update(schedule)..where((tbl) => tbl.id.equals(id))).write(
      ScheduleCompanion(isEaten: Value(isEaten)),
    );
  }

  Future<void> unassignRecipeFromMeal(int id) {
    return (update(schedule)..where((tbl) => tbl.id.equals(id))).write(
      ScheduleCompanion(recipeId: Value(null)),
    );
  }

  DateTime _getStartOfWeek(DateTime date) {
    final weekday = date.weekday;
    return date.subtract(Duration(days: weekday - 1));
  }
}
