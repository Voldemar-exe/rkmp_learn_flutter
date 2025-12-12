import 'package:dio/dio.dart';

import 'exceptions.dart';
import 'interceptors/error_handling_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

class DioClient {
  final Dio _dio;

  DioClient({
    required String baseUrl,
    int connectTimeout = 10000,
    int receiveTimeout = 10000,
  }) : _dio = Dio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = Duration(milliseconds: connectTimeout);
    _dio.options.receiveTimeout = Duration(milliseconds: receiveTimeout);

    _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(ErrorHandlingInterceptor());
  }

  Future<T> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } catch (e) {
      if (e is DioException) rethrow;
      throw NetworkException('Ошибка при выполнении GET запроса');
    }
  }

  Future<T> post<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(path, queryParameters: queryParameters);
      return response.data;
    } catch (e) {
      if (e is DioException) rethrow;
      throw NetworkException('Ошибка при выполнении POST запроса');
    }
  }

  Dio get instance => _dio;
}
