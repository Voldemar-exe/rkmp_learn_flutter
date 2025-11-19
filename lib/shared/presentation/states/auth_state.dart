import 'package:rkmp_learn_flutter/shared/data/models/user_model.dart';

sealed class AuthState {
  const AuthState();
}

final class Unauthenticated extends AuthState {
  const Unauthenticated();
}

final class Loading extends AuthState {
  const Loading();
}

final class Authenticated extends AuthState {
  final UserModel user;

  const Authenticated({required this.user});
}