import '../../../../core/models/user.dart';
import '../dto/api_create_user_dto.dart';
import 'auth_api.dart';
import '../dto/mappers/api_auth_mapper.dart';

class AuthApiDataSource {
  final AuthApi _api;

  AuthApiDataSource(this._api);

  Future<User> login(String username, String password) async {
    final response = await _api.login(
      credentials: {
        'username': username,
        'password': password,
        'expiresInMins': 30,
      },
    );

    return response.toModel();
  }

  Future<User> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final firstName = username.split('_').first;
    final lastName = username.contains('_')
        ? username.split('_').last
        : 'User';

    final requestDto = CreateUserRequestDto(
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      password: password,
      age: 25,
    );

    final response = await _api.registerUser(requestDto);
    return response.toModel();
  }

  Future<void> deleteUser(int userId) async {
    final response = await _api.deleteUser(userId);
    final isDeleted = response.isDeleted == true;
    if (!isDeleted) {
      throw Exception('Failed to delete user $userId');
    }
  }
}
