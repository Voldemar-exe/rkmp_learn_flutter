// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiAuthDto _$ApiAuthDtoFromJson(Map<String, dynamic> json) => ApiAuthDto(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  gender: json['gender'] as String,
  image: json['image'] as String,
);

Map<String, dynamic> _$ApiAuthDtoToJson(ApiAuthDto instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'image': instance.image,
    };

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: (json['id'] as num).toInt(),
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  maidenName: json['maidenName'] as String?,
  age: (json['age'] as num?)?.toInt(),
  gender: json['gender'] as String?,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  username: json['username'] as String,
  password: json['password'] as String,
  birthDate: json['birthDate'] as String?,
  image: json['image'] as String?,
  bloodGroup: json['bloodGroup'] as String?,
  height: (json['height'] as num?)?.toDouble(),
  weight: (json['weight'] as num?)?.toDouble(),
  eyeColor: json['eyeColor'] as String?,
  hair: json['hair'] == null
      ? null
      : HairDto.fromJson(json['hair'] as Map<String, dynamic>),
  isDeleted: json['isDeleted'] as bool?,
  deletedOn: json['deletedOn'] as String?,
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'maidenName': instance.maidenName,
  'age': instance.age,
  'gender': instance.gender,
  'email': instance.email,
  'phone': instance.phone,
  'username': instance.username,
  'password': instance.password,
  'birthDate': instance.birthDate,
  'image': instance.image,
  'bloodGroup': instance.bloodGroup,
  'height': instance.height,
  'weight': instance.weight,
  'eyeColor': instance.eyeColor,
  'hair': instance.hair,
  'isDeleted': instance.isDeleted,
  'deletedOn': instance.deletedOn,
};

HairDto _$HairDtoFromJson(Map<String, dynamic> json) =>
    HairDto(color: json['color'] as String, type: json['type'] as String);

Map<String, dynamic> _$HairDtoToJson(HairDto instance) => <String, dynamic>{
  'color': instance.color,
  'type': instance.type,
};
