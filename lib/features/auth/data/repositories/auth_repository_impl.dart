import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/local/auth_local_data_source.dart';
import '../data_sources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<UserEntity?> login(String login, String password) async {
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
  Future<UserEntity?> register(
    String login,
    String? email,
    String password,
  ) async {
    try {
      final user = await _remoteDataSource.register(
        login: login,
        email: email,
        password: password,
      );
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
  Future<UserEntity?> checkAuthStatus() async {
    return await _localDataSource.getCurrentUser();
  }
}
