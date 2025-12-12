import 'package:get_it/get_it.dart';

import '../../../../data/datasources/local/database/dao/recipe_dao.dart';
import '../../../../data/datasources/local/recipes_local_data_source.dart';
import '../../../../data/datasources/remote/api/dio_client.dart';
import '../../../../data/datasources/remote/api/recipes_api_datasource.dart';
import '../../../../data/repositories/recipe_repository_impl.dart';
import '../../../../domain/interfaces/repositories/recipe_repository.dart';
import '../delegates/recipes_view_model.dart';

void registerRecipesDependencies() {
  GetIt.I.registerLazySingleton<DioClient>(
    () => DioClient(baseUrl: 'https://www.themealdb.com/api/json/v1/1/'),
  );
  GetIt.I.registerLazySingleton<RecipesApiDataSource>(
    () => RecipesApiDataSource(GetIt.I<DioClient>().instance),
  );
  GetIt.I.registerLazySingleton<DriftRecipesLocalDataSource>(
    () => DriftRecipesLocalDataSource(GetIt.I<RecipeDao>()),
  );

  GetIt.I.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(
      remoteDataSource: GetIt.I(),
      localDataSource: GetIt.I(),
    ),
  );

  GetIt.I.registerLazySingleton<RecipesViewModel>(() => RecipesViewModel());
}
