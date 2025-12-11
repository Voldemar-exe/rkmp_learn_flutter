import 'package:rkmp_learn_flutter/data/datasources/api/dto/api_auth_dto.dart';

import '../../../../../core/models/user.dart';

extension ApiAuthMapper on ApiAuthDto {
  User dtoToUser() {
    return User(
      id: int.parse(id),
      login: login,
      email: email,
      createdAt: DateTime.parse(createdAt),
    );
  }
}

extension UserToApiMapper on User {
  ApiAuthDto userToDto() {
    return ApiAuthDto(
      id: id.toString(),
      login: login,
      email: email,
      password: '',
      createdAt: createdAt.toIso8601String(),
    );
  }
}
