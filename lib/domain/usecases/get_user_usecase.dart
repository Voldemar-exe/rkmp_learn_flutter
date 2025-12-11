import '../../core/models/user.dart';
import '../interfaces/repositories/auth_repository.dart';

class GetUserUseCase {
  final AuthRepository _repository;

  GetUserUseCase(this._repository);

  Future<User?> execute() async {
    final authStatus = await _repository.checkAuthStatus();
    if (authStatus == null) return null;
    return User(
      id: authStatus.id,
      login: authStatus.login,
      email: authStatus.email,
      createdAt: authStatus.createdAt,
    );
  }
}
