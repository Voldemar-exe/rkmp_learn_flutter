import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rkmp_learn_flutter/data/database/tables/ingredient_table.dart';
import 'package:rkmp_learn_flutter/data/database/tables/recipe_table.dart';
import 'package:rkmp_learn_flutter/data/database/tables/schedule_table.dart';

import 'dao/ingredient_dao.dart';
import 'dao/recipe_dao.dart';
import 'dao/schedule_dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Ingredients,
    Recipes,
    Schedule
  ],
  daos: [
    IngredientDao,
    RecipeDao,
    ScheduleDao
  ]
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
        onResult: (result) {
          if (result.missingFeatures.isNotEmpty) {
            debugPrint(
              'Using ${result.chosenImplementation} due to unsupported '
                  'browser features: ${result.missingFeatures}',
            );
          }
        },
      ),
    );
  }
}

