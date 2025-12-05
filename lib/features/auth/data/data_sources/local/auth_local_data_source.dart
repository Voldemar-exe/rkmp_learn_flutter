import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../domain/entities/user_entity.dart';

class AuthLocalDataSource {
  static const _currentUserKey = 'current_user';
  static const _tokenKey = 'auth_token';

  final SharedPreferencesAsync _prefs;

  AuthLocalDataSource(this._prefs);

  Future<void> saveCurrentUser(UserEntity user) async {
    final userData = {
      'id': user.id,
      'email': user.email,
      'name': user.login,
      'created_at': user.createdAt.toIso8601String(),
    };
    await _prefs.setString(_currentUserKey, jsonEncode(userData));
  }

  Future<UserEntity?> getCurrentUser() async {
    final jsonString = await _prefs.getString(_currentUserKey);
    if (jsonString == null) return null;

    final userData = jsonDecode(jsonString) as Map<String, dynamic>;
    return UserEntity(
      id: userData['id'],
      email: userData['email'],
      login: userData['name'],
      createdAt: DateTime.parse(userData['created_at']),
    );
  }

  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }

  Future<void> clearAuthData() async {
    await _prefs.remove(_currentUserKey);
    await _prefs.remove(_tokenKey);
  }
}