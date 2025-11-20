import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/features/schedule/data/data_sources/local/schedule_local_data_source.dart';

void registerScheduleDependencies() {
  GetIt.I.registerLazySingleton<ScheduleLocalDataSource>(
    () => ScheduleLocalDataSource(),
  );
}
