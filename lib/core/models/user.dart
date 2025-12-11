class User {
  final int id;
  final String login;
  final String email;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.login,
    required this.email,
    required this.createdAt,
  });

  User copyWith({
    int? id,
    String? login,
    String? email,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      login: login ?? this.login,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
