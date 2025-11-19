class UserEntity {
  final String id;
  final String login;
  final String? email;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.login,
    this.email,
    required this.createdAt,
  });
}