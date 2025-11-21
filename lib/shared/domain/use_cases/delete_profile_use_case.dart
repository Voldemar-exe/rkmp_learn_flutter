import 'package:rkmp_learn_flutter/features/auth/domain/repositories/auth_repository.dart';

class DeleteProfileUseCase {
  final AuthRepository _repository;

  DeleteProfileUseCase(this._repository);

  Future<void> call() async {
    final user = await _repository.checkAuthStatus();
    await _repository.deleteProfile(user!.id);
    await _repository.logout();
  }
}
