import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/features/ingredients/data/data_sources/local/ingredients_local_data_source.dart';
import 'package:rkmp_learn_flutter/features/ingredients/data/data_sources/remote/ingredients_remote_data_source.dart';
import 'package:rkmp_learn_flutter/features/ingredients/domain/repositories/ingredient_repository.dart';

import '../data/repositories/ingredient_repository_impl.dart';
import '../presentation/store/ingredients_view_model.dart';

void registerIngredientsDependencies() {
  GetIt.I.registerLazySingleton<IngredientsLocalDataSource>(
    () => IngredientsLocalDataSource(),
  );
  GetIt.I.registerLazySingleton<IngredientsRemoteDataSource>(
    () => IngredientsRemoteDataSource(),
  );
  GetIt.I.registerLazySingleton<IngredientRepository>(
    () => IngredientRepositoryImpl(
      GetIt.I<IngredientsLocalDataSource>(),
      GetIt.I<IngredientsRemoteDataSource>(),
    ),
  );
  GetIt.I.registerLazySingleton<IngredientsViewModel>(
    () => IngredientsViewModel(),
  );
}
