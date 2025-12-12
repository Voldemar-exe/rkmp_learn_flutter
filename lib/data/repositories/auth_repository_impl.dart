import 'package:get_it/get_it.dart';

import '../../core/models/user.dart';
import '../../domain/interfaces/repositories/auth_repository.dart';
import '../../domain/usecases/save_profile_usecase.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../datasources/remote/api/auth_api_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiDataSource _remoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl({
    required AuthApiDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _authLocalDataSource = localDataSource;

  @override
  Future<User?> login(String login, String password) async {
    try {
      final user = await _remoteDataSource.login(login, password);
      await _authLocalDataSource.saveCurrentUser(user);
      await _authLocalDataSource.saveToken('token_${user.id}');
      GetIt.I<SaveProfileUseCase>().execute(
        "${user.firstName} ${user.lastName}",
      );
      return user;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<User?> register(String login, String email, String password) async {
    try {
      final user = await _remoteDataSource.register(
        username: login,
        email: email,
        password: password,
      );
      await _authLocalDataSource.saveCurrentUser(user);
      await _authLocalDataSource.saveToken('token_${user.id}');
      GetIt.I<SaveProfileUseCase>().execute(user.username);
      return user;
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    await _authLocalDataSource.clearAuthData();
  }

  @override
  Future<User?> checkAuthStatus() async {
    return await _authLocalDataSource.getCurrentUser();
  }

  @override
  Future<void> deleteProfile(int userId) async {
    await _remoteDataSource.deleteUser(userId);
    await _authLocalDataSource.clearAuthData();
  }
}
