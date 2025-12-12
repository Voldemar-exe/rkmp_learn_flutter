import 'package:get_it/get_it.dart';

import '../../../../data/datasources/local/database/dao/recipe_dao.dart';
import '../../../../data/datasources/local/database/dao/schedule_dao.dart';
import '../../../../data/datasources/local/schedule_local_data_source.dart';

void registerScheduleDependencies() {
  GetIt.I.registerLazySingleton<DriftScheduleLocalDataSource>(
    () => DriftScheduleLocalDataSource(
      scheduleDao: GetIt.I<ScheduleDao>(),
      recipeDao: GetIt.I<RecipeDao>(),
    ),
  );
}
