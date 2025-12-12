class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class TimeoutException extends NetworkException {
  TimeoutException() : super('Таймаут соединения');
}

class BadRequestException extends NetworkException {
  BadRequestException(super.message);
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException() : super('Неавторизован');
}

class ServerException extends NetworkException {
  ServerException() : super('Ошибка сервера');
}