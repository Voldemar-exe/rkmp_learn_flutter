import '../../../../core/models/user.dart';

class PrefsUserDto {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  PrefsUserDto({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory PrefsUserDto.fromModel(User user) {
    return PrefsUserDto(
      id: user.id,
      username: user.username,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
    );
  }

  User toModel() {
    return User(
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
    );
  }
}