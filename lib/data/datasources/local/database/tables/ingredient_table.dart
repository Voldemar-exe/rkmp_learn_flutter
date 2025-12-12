import 'package:drift/drift.dart';

@DataClassName("IngredientEntity")
class Ingredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get measureUnit => text().nullable()();
  RealColumn get amount => real()();
}