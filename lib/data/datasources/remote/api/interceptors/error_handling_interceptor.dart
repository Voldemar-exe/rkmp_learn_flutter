import 'package:dio/dio.dart';

import '../exceptions.dart';

class ErrorHandlingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      handler.reject(DioException(
        error: TimeoutException(),
        type: err.type,
        requestOptions: err.requestOptions,
      ));
    }

    if (err.response?.statusCode != null) {
      switch (err.response!.statusCode) {
        case 400:
          handler.reject(DioException(
            error: BadRequestException('Некорректный запрос'),
            requestOptions: err.requestOptions,
          ));
        case 401:
          handler.reject(DioException(
            error: UnauthorizedException(),
            requestOptions: err.requestOptions,
          ));
        case 500:
        case 502:
        case 503:
          handler.reject(DioException(
            error: ServerException(),
            requestOptions: err.requestOptions,
          ));
      }
    }
    handler.next(err);
  }
}