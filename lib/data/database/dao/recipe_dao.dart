import 'dart:convert';

import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/recipe_table.dart';

part 'recipe_dao.g.dart';

@DriftAccessor(tables: [Recipes])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  RecipeDao(super.db);

  Future<List<RecipeEntity>> getAllRecipes() => select(recipes).get();

  Future<void> insertRecipe({
    int? id,
    required String name,
    required String category,
    required String area,
    required String instructions,
    required String imageUrl,
    required Map<String, String> ingredientsWithMeasure,
  }) async {
    final jsonIngredients = jsonEncode(ingredientsWithMeasure);
    final companion = RecipesCompanion(
      id: id != null ? Value(id) : const Value.absent(),
      name: Value(name),
      category: Value(category),
      area: Value(area),
      instructions: Value(instructions),
      imageUrl: Value(imageUrl),
      ingredientsWithMeasure: Value(jsonIngredients),
    );
    await into(recipes).insertOnConflictUpdate(companion);
  }

  Future<List<RecipeEntity>> searchByName(String query) {
    return (select(recipes)..where((tbl) => tbl.name.like('%$query%'))).get();
  }

  Future<RecipeEntity?> getById(int id) {
    return (select(
      recipes,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<void> deleteRecipe(int id) {
    return (delete(recipes)..where((tbl) => tbl.id.equals(id))).go();
  }
}
