import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/features/ingredients/data/data_sources/local/ingredients_local_data_source.dart';
import 'package:rkmp_learn_flutter/features/ingredients/data/data_sources/remote/ingredients_remote_data_source.dart';
import 'package:rkmp_learn_flutter/features/ingredients/data/repositories/ingredient_repository_impl.dart';
import 'package:rkmp_learn_flutter/features/ingredients/domain/repositories/ingredient_repository.dart';
import 'package:rkmp_learn_flutter/features/ingredients/presentation/store/ingredients_view_model.dart';
import 'package:rkmp_learn_flutter/shared/data/database/dao/ingredient_dao.dart';


void registerIngredientsDependencies() {
  GetIt.I.registerLazySingleton<IngredientsLocalDataSource>(
    () => IngredientsLocalDataSource(
      GetIt.I<IngredientDao>(),
    ),
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
