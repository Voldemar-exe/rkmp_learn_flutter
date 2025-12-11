import 'package:drift/drift.dart';

class Recipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get area => text()();
  TextColumn get instructions => text()();
  TextColumn get imageUrl => text()();
  TextColumn get ingredientsWithMeasure => text()();
}