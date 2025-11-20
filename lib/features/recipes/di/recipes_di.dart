import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/features/recipes/data/data_sources/local/recipes_local_data_source.dart';
import 'package:rkmp_learn_flutter/features/recipes/data/data_sources/remote/recipes_remote_data_source.dart';
import 'package:rkmp_learn_flutter/features/recipes/data/repositories/recipe_repository_impl.dart';
import 'package:rkmp_learn_flutter/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:rkmp_learn_flutter/features/recipes/presentation/store/recipes_view_model.dart';

void registerRecipesDependencies() {
  GetIt.I.registerLazySingleton<RecipesRemoteDataSource>(
    () => RecipesRemoteDataSource(),
  );
  GetIt.I.registerLazySingleton<RecipesLocalDataSource>(
    () => RecipesLocalDataSource(),
  );

  GetIt.I.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(
      remoteDataSource: GetIt.I(),
      localDataSource: GetIt.I(),
    ),
  );

  GetIt.I.registerLazySingleton<RecipesViewModel>(() => RecipesViewModel());
}
