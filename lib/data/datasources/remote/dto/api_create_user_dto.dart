import 'package:json_annotation/json_annotation.dart';

part 'api_create_user_dto.g.dart';

@JsonSerializable()
class CreateUserRequestDto {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final int age;
  final String? gender;
  final String? birthDate;
  final String? phone;

  CreateUserRequestDto({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
    this.age = 18,
    this.gender,
    this.birthDate,
    this.phone,
  });

  Map<String, dynamic> toJson() => _$CreateUserRequestDtoToJson(this);
}

@JsonSerializable()
class ApiUserResponseDto {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;

  ApiUserResponseDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
  });

  factory ApiUserResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ApiUserResponseDtoFromJson(json);
}