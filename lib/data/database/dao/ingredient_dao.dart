import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/ingredient_table.dart';

part 'ingredient_dao.g.dart';

@DriftAccessor(tables: [Ingredients])
class IngredientDao extends DatabaseAccessor<AppDatabase>
    with _$IngredientDaoMixin {
  IngredientDao(super.db);

  Stream<List<IngredientEntity>> watchAllIngredients() {
    return select(ingredients).watch();
  }

  Future<List<IngredientEntity>> getAllIngredients() =>
      select(ingredients).get();

  Future<int> insertOrUpdateIngredient(
    String name,
    String? measureUnit,
    double? amount,
    int? id,
  ) async {
    final companion = IngredientsCompanion(
      id: id != null && id > 0 ? Value(id) : const Value.absent(),
      name: Value(name),
      measureUnit: Value(measureUnit),
      amount: Value(amount ?? 0.0),
    );

    if (id != null && id > 0) {
      await into(ingredients).insertOnConflictUpdate(companion);
      return id;
    } else {
      return await into(ingredients).insert(companion);
    }
  }

  Future<void> deleteIngredient(int id) {
    return (delete(ingredients)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> updateAmount(int id, double amount) {
    return (update(ingredients)..where((tbl) => tbl.id.equals(id))).write(
      IngredientsCompanion(amount: Value(amount)),
    );
  }

  Future<void> consumeAmount(int id, double amount) async {
    final current = await (select(
      ingredients,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    final newAmount = current.amount - amount;
    if (newAmount < 0) {
      await updateAmount(id, 0.0);
    } else {
      await updateAmount(id, newAmount);
    }
  }
}
