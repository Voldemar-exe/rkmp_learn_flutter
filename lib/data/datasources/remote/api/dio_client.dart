import 'package:dio/dio.dart';

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

  Dio get instance => _dio;
}