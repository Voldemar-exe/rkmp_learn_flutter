import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/recipe.dart';
import '../../../domain/usecases/get_user_recipes_usecase.dart';

part 'user_recipes_notifier.g.dart';

@riverpod
Future<List<Recipe>> userRecipes(Ref ref) async {
  final useCase = GetIt.I<GetUserRecipesUseCase>();
  return await useCase.execute();
}
