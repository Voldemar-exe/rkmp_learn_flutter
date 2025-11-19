import '../../../domain/entities/user_entity.dart';

class AuthRemoteDatasource {

  static final List<Map<String, dynamic>> _users = [
    {
      'id': '1',
      'login': 'jonny_123',
      'email': 'john@example.com',
      'password': 'Password123',
      'created_at': DateTime.now().toIso8601String(),
    },
    {
      'id': '2',
      'login': 'jane_123',
      'email': 'smith@example.com',
      'password': 'Password123',
      'created_at': DateTime.now().toIso8601String(),
    },
  ];

  Future<UserEntity?> login(String login, String password) async {

    // Delay simulation
    await Future.delayed(const Duration(milliseconds: 500));

    final user = _users.firstWhere(
          (u) => u['login'] == login && u['password'] == password,
      orElse: () => throw Exception('Invalid credentials'),
    );

    return UserEntity(
      id: user['id'],
      login: user['login'],
      email: user['email'],
      createdAt: DateTime.parse(user['created_at']),
    );
  }

  Future<UserEntity> register({
    required String login,
    required String password,
    String? email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (_users.any((u) => u['login'] == login)) {
      throw Exception('User already exists');
    }

    if (_users.any((u) => u['email'] == email)) {
      throw Exception('Email already in use');
    }

    final Map<String, String> newUser = {
      'id': '${DateTime.now().millisecondsSinceEpoch}',
      'login': login,
      'email': email.toString(),
      'password': password,
      'created_at': DateTime.now().toIso8601String(),
    };

    _users.add(newUser);

    // TODO: error with null
    return UserEntity(
      id: newUser['id']!,
      login: newUser['login']!,
      email: newUser['email']!,
      createdAt: DateTime.parse(newUser['created_at']!),
    );
  }
}