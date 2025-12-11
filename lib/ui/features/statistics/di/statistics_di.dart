import 'package:get_it/get_it.dart';

import '../../../../data/datasources/api/ingredients_api_datasource.dart';
import '../../../../data/datasources/local/schedule_local_data_source.dart';
import '../../../../data/datasources/local/statistics_data_source.dart';

void registerStatisticsDependencies() {
  GetIt.I.registerLazySingleton<StatisticsLocalDataSource>(
    () => StatisticsLocalDataSource(
      GetIt.I<DriftScheduleLocalDataSource>(),
      GetIt.I<IngredientsApiDataSource>(),
    ),
  );
}