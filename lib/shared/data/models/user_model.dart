import 'package:rkmp_learn_flutter/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.login,
    super.email,
    required super.createdAt,
  });

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      login: entity.login,
      email: entity.email,
      createdAt: entity.createdAt,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      login: json['login'],
      email: json['email'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'email': email,
      'created_at': createdAt.toIso8601String(),
    };
  }
}