import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/domain/usecases/get_user_usecase.dart';

import '../states/auth_state.dart';


part 'auth_notifier.g.dart';

@riverpod
Future<AuthState> checkAuthStatus(Ref ref) async {
  final useCase = GetIt.I<GetUserUseCase>();
  final user = await useCase.execute();
  if (user != null) {
    return Authenticated(user: user);
  }
  return const Unauthenticated();
}
