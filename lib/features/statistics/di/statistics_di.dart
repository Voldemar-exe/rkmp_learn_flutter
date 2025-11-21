import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/features/ingredients/data/data_sources/remote/ingredients_remote_data_source.dart';
import 'package:rkmp_learn_flutter/features/schedule/data/data_sources/local/schedule_local_data_source.dart';
import 'package:rkmp_learn_flutter/features/statistics/data/data_sources/statistics_data_source.dart';

void registerStatisticsDependencies() {
  GetIt.I.registerLazySingleton<StatisticsLocalDataSource>(
    () => StatisticsLocalDataSource(
      GetIt.I<ScheduleLocalDataSource>(),
      GetIt.I<IngredientsRemoteDataSource>(),
    ),
  );
}