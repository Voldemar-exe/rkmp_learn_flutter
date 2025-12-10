import 'package:drift/drift.dart';
import 'package:rkmp_learn_flutter/shared/data/database/database.dart';
import 'package:rkmp_learn_flutter/shared/data/database/tables/recipe_table.dart';

part 'recipe_dao.g.dart';

@DriftAccessor(tables: [Recipes])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  RecipeDao(super.db);

  Future<List<Recipe>> getAllRecipes() => select(recipes).get();

  Future<void> insertRecipe(RecipesCompanion recipe) => into(recipes).insert(recipe);

  Future<List<Recipe>> searchByName(String query) {
    return (select(recipes)..where((tbl) => tbl.name.like('%$query%'))).get();
  }

  Future<Recipe?> getById(int id) {
    return (select(recipes)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<void> deleteRecipe(int id) {
    return (delete(recipes)..where((tbl) => tbl.id.equals(id))).go();
  }
}