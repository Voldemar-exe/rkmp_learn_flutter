import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/models/user.dart';
import 'dto/prefs_auth_dto.dart';

class AuthLocalDataSource {
  static const _currentUserKey = 'current_user';
  static const _tokenKey = 'auth_token';
  final FlutterSecureStorage _storage;

  AuthLocalDataSource(this._storage);

  Future<void> saveCurrentUser(User user) async {
    final dto = PrefsUserDto.fromModel(user);
    final json = jsonEncode({
      'id': dto.id,
      'username': dto.username,
      'email': dto.email,
      'firstName': dto.firstName,
      'lastName': dto.lastName,
    });
    await _storage.write(key: _currentUserKey, value: json);
  }

  Future<User?> getCurrentUser() async {
    final jsonString = await _storage.read(key: _currentUserKey);
    if (jsonString == null) return null;

    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final dto = PrefsUserDto(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );
    return dto.toModel();
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> clearAuthData() async {
    await _storage.delete(key: _currentUserKey);
    await _storage.delete(key: _tokenKey);
  }
}