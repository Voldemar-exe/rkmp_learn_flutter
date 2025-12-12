import 'package:get_it/get_it.dart';

import '../../../../data/datasources/local/database/dao/ingredient_dao.dart';
import '../../../../data/datasources/local/ingredients_local_datasource.dart';
import '../../../../data/datasources/remote/api/ingredients_api_datasource.dart';
import '../../../../data/repositories/ingredient_repository_impl.dart';
import '../../../../domain/interfaces/repositories/ingredient_repository.dart';
import '../delegates/ingredients_view_model.dart';

void registerIngredientsDependencies() {
  GetIt.I.registerLazySingleton<DriftIngredientsLocalDataSource>(
    () => DriftIngredientsLocalDataSource(GetIt.I<IngredientDao>()),
  );
  GetIt.I.registerLazySingleton<IngredientsApiDataSource>(
    () => IngredientsApiDataSource(),
  );
  GetIt.I.registerLazySingleton<IngredientRepository>(
    () => IngredientRepositoryImpl(
      GetIt.I<DriftIngredientsLocalDataSource>(),
      GetIt.I<IngredientsApiDataSource>(),
    ),
  );
  GetIt.I.registerLazySingleton<IngredientsViewModel>(
    () => IngredientsViewModel(),
  );
}
