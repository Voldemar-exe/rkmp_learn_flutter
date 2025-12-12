import '../../../../../core/models/user.dart';
import '../api_auth_dto.dart';

extension UserDtoMapper on UserDto {
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

extension ApiAuthDtoMapper on ApiAuthDto {
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
