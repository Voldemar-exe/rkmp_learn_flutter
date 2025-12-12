import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rkmp_learn_flutter/data/datasources/remote/dto/api_create_user_dto.dart';

import '../dto/api_auth_dto.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: "https://dummyjson.com")
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST("/auth/login")
  Future<ApiAuthDto> login({
    @Body() required Map<String, dynamic> credentials,
  });

  @POST("/users/add")
  Future<UserDto> registerUser(@Body() CreateUserRequestDto user);

  @DELETE("/users/{id}")
  Future<UserDto> deleteUser(@Path("id") int id);
}