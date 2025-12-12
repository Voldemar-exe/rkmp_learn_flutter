import 'package:json_annotation/json_annotation.dart';

part 'api_auth_dto.g.dart';

@JsonSerializable()
class ApiAuthDto {
  final String accessToken;
  final String refreshToken;
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;

  ApiAuthDto({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  });

  factory ApiAuthDto.fromJson(Map<String, dynamic> json) =>
      _$ApiAuthDtoFromJson(json);
}

@JsonSerializable()
class UserDto {
  final int id;
  final String firstName;
  final String lastName;
  final String? maidenName;
  final int? age;
  final String? gender;
  final String email;
  final String? phone;
  final String username;
  final String password;
  final String? birthDate;
  final String? image;
  final String? bloodGroup;
  final double? height;
  final double? weight;
  final String? eyeColor;
  final HairDto? hair;
  final bool? isDeleted;
  final String? deletedOn;

  UserDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.maidenName,
    this.age,
    this.gender,
    required this.email,
    this.phone,
    required this.username,
    required this.password,
    this.birthDate,
    this.image,
    this.bloodGroup,
    this.height,
    this.weight,
    this.eyeColor,
    this.hair,
    this.isDeleted,
    this.deletedOn,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

@JsonSerializable()
class HairDto {
  final String color;
  final String type;

  HairDto({required this.color, required this.type});

  factory HairDto.fromJson(Map<String, dynamic> json) =>
      _$HairDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HairDtoToJson(this);
}
