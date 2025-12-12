import '../../core/models/user.dart';
import '../../domain/interfaces/repositories/auth_repository.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../datasources/remote/api/auth_api_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthApiDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<User?> login(String login, String password) async {
    try {
      final user = await _remoteDataSource.login(login, password);
      if (user != null) {
        await _localDataSource.saveCurrentUser(user);
        await _localDataSource.saveToken('token_${user.id}');
      }
      return user;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<User?> register(String login, String email, String password) async {
    try {
      final user = await _remoteDataSource.register(login, password, email);
      await _localDataSource.saveCurrentUser(user);
      await _localDataSource.saveToken('token_${user.id}');
      return user;
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    await _localDataSource.clearAuthData();
  }

  @override
  Future<User?> checkAuthStatus() async {
    return await _localDataSource.getCurrentUser();
  }

  @override
  Future<void> deleteProfile(int userId) async {
    await _remoteDataSource.deleteProfile(userId);
    await _localDataSource.clearAuthData();
  }
}
