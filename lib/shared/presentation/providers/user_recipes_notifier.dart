import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/features/recipes/data/models/recipe.dart';
import 'package:rkmp_learn_flutter/shared/domain/use_cases/get_user_recipes_use_case.dart';

part 'user_recipes_notifier.g.dart';

@riverpod
Future<List<Recipe>> userRecipes(Ref ref) async {
  final useCase = GetIt.I<GetUserRecipesUseCase>();
  return await useCase.call();
}
