import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/shared/domain/use_cases/get_user_use_case.dart';
import 'package:rkmp_learn_flutter/shared/presentation/states/auth_state.dart';

part 'auth_notifier.g.dart';

@riverpod
Future<AuthState> checkAuthStatus(Ref ref) async {
  final useCase = GetIt.I<GetUserUseCase>();
  final user = await useCase.call();
  if (user != null) {
    return Authenticated(user: user);
  }
  return const Unauthenticated();
}
