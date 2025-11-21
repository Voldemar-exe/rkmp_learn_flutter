import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/shared/domain/use_cases/get_user_ingredients_use_case.dart';

part 'user_ingredients_notifier.g.dart';

@riverpod
Future<Map<String, double>> userIngredients(Ref ref) async {
  final useCase = GetIt.I<GetUserIngredientsWithAmountUseCase>();
  return await useCase.call();
}
