import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/local/auth_local_data_source.dart';
import '../data_sources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;
  final AuthLocalDatasource _localDatasource;

  AuthRepositoryImpl({
    required AuthRemoteDatasource remoteDatasource,
    required AuthLocalDatasource localDatasource,
  }) : _remoteDatasource = remoteDatasource,
       _localDatasource = localDatasource;

  @override
  Future<UserEntity?> login(String login, String password) async {
    try {
      final user = await _remoteDatasource.login(login, password);
      if (user != null) {
        await _localDatasource.saveCurrentUser(user);
        await _localDatasource.saveToken('token_${user.id}');
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
      final user = await _remoteDatasource.register(
        login: login,
        email: email,
        password: password,
      );
      await _localDatasource.saveCurrentUser(user);
      await _localDatasource.saveToken('token_${user.id}');
      return user;
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    await _localDatasource.clearAuthData();
  }

  @override
  Future<UserEntity?> checkAuthStatus() async {
    return await _localDatasource.getCurrentUser();
  }
}
