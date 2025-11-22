import 'package:rkmp_learn_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:rkmp_learn_flutter/shared/data/models/user.dart';

class GetUserUseCase {
  final AuthRepository _repository;

  GetUserUseCase(this._repository);

  Future<User?> call() async {
    final authStatus = await _repository.checkAuthStatus();
    if (authStatus == null) return null;
    return User(
      id: authStatus.id,
      login: authStatus.login,
      createdAt: authStatus.createdAt,
    );
  }
}
