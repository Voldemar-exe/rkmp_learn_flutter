import 'package:drift/drift.dart';

class Schedule extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get date => text()();
  TextColumn get mealTime => text()();
  IntColumn get recipeId => integer().nullable()();
  BoolColumn get isEaten => boolean().withDefault(const Constant(false))();
}