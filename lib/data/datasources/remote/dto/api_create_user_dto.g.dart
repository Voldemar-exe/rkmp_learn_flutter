// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_create_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserRequestDto _$CreateUserRequestDtoFromJson(
  Map<String, dynamic> json,
) => CreateUserRequestDto(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  age: (json['age'] as num?)?.toInt() ?? 18,
  gender: json['gender'] as String?,
  birthDate: json['birthDate'] as String?,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$CreateUserRequestDtoToJson(
  CreateUserRequestDto instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'username': instance.username,
  'email': instance.email,
  'password': instance.password,
  'age': instance.age,
  'gender': instance.gender,
  'birthDate': instance.birthDate,
  'phone': instance.phone,
};

ApiUserResponseDto _$ApiUserResponseDtoFromJson(Map<String, dynamic> json) =>
    ApiUserResponseDto(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$ApiUserResponseDtoToJson(ApiUserResponseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
      'email': instance.email,
    };
