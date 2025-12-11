import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/get_user_ingredients_usecase.dart';

part 'user_ingredients_notifier.g.dart';

@riverpod
Future<Map<String, double>> userIngredients(Ref ref) async {
  final useCase = GetIt.I<GetUserIngredientsWithAmountUseCase>();
  return await useCase.execute();
}
