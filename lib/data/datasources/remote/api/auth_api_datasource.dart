import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/data/datasources/remote/dto/mappers/api_auth_mapper.dart';
import '../../../../core/models/user.dart';
import '../dto/api_auth_dto.dart';
import 'profile_api_data_source.dart';

class AuthApiDataSource {
  static final List<ApiAuthDto> _users = [
    ApiAuthDto.fromJson({
      'id': '1',
      'login': 'jonny_123',
      'email': 'john@example.com',
      'password': '123',
      'created_at': DateTime.now().toIso8601String(),
    }),
    ApiAuthDto.fromJson({
      'id': '2',
      'login': 'jane_123',
      'email': 'smith@example.com',
      'password': '12345',
      'created_at': DateTime.now().toIso8601String(),
    }),
  ];

  Future<User?> login(String login, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final dto = _users.firstWhere(
      (u) => u.login == login && u.password == password,
      orElse: () => throw Exception('Invalid credentials'),
    );

    return dto.dtoToUser();
  }

  Future<User> register(String login, String password, String email) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (_users.any((u) => u.login == login)) {
      throw Exception('User already exists');
    }
    if (_users.any((u) => u.email == email)) {
      throw Exception('Email already in use');
    }

    final newUserDto = ApiAuthDto(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      login: login,
      email: email,
      password: password,
      createdAt: DateTime.now().toIso8601String(),
    );

    _users.add(newUserDto);

    // SIMULATION: add row to profile table
    GetIt.I<ProfileApiDataSource>().addProfile(
      login,
      int.parse(newUserDto.id),
    );

    return newUserDto.dtoToUser();
  }

  Future<void> deleteProfile(int userId) async {
    _users.removeWhere((u) => u.id == userId.toString());
    GetIt.I<ProfileApiDataSource>().deleteProfile(userId);
  }
}
