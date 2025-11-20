import '../../../domain/entities/user_entity.dart';

class AuthLocalDataSource {
  static const _currentUserKey = 'current_user';
  static const _tokenKey = 'auth_token';

  static final Map<String, dynamic> _storage = <String, dynamic>{};

  Future<void> saveCurrentUser(UserEntity user) async {
    _storage[_currentUserKey] = {
      'id': user.id,
      'email': user.email,
      'name': user.login,
      'created_at': user.createdAt.toIso8601String(),
    };
  }

  Future<UserEntity?> getCurrentUser() async {
    final userData = _storage[_currentUserKey];
    if (userData != null) {
      return UserEntity(
        id: userData['id'],
        email: userData['email'],
        login: userData['name'],
        createdAt: DateTime.parse(userData['created_at']),
      );
    }
    return null;
  }

  Future<void> saveToken(String token) async {
    _storage[_tokenKey] = token;
  }

  Future<String?> getToken() async {
    return _storage[_tokenKey] as String?;
  }

  Future<void> clearAuthData() async {
    _storage.remove(_currentUserKey);
    _storage.remove(_tokenKey);
  }
}