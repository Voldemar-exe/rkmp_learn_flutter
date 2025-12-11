import '../../../core/models/user.dart';

abstract class AuthRepository {
  Future<User?> login(String login, String password);

  Future<User?> register(String login, String email, String password);

  Future<void> logout();

  Future<User?> checkAuthStatus();

  Future<void> deleteProfile(int userId);
}
