import '../../../../core/models/user.dart';

class PrefsUserDto {
  final int id;
  final String email;
  final String login;
  final String createdAtIso;

  PrefsUserDto({
    required this.id,
    required this.email,
    required this.login,
    required this.createdAtIso,
  });

  factory PrefsUserDto.fromModel(User user) {
    return PrefsUserDto(
      id: user.id,
      email: user.email,
      login: user.login,
      createdAtIso: user.createdAt.toIso8601String(),
    );
  }

  User toModel() {
    return User(
      id: id,
      email: email,
      login: login,
      createdAt: DateTime.parse(createdAtIso),
    );
  }
}