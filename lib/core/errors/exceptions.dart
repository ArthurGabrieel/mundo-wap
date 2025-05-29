import 'package:dio/dio.dart';

import '../config/constants/app_messages.dart';

abstract class AppException implements Exception {
  final String? message;
  final StackTrace? stackTrace;

  AppException({this.message, this.stackTrace});

  @override
  String toString() {
    if (stackTrace != null) {
      return '$runtimeType: $message\n$stackTrace';
    }
    return '$runtimeType: $message';
  }
}

class ServerException extends AppException {
  ServerException({super.message, this.response, super.stackTrace});

  final Response? response;

  @override
  String toString() {
    final message =
        response?.data['message'] as String? ?? 'Erro na requisição';
    final description = response?.data['description'] as String? ?? '';
    if (response != null) {
      return '$runtimeType - message: $message, description: $description, statusCode: ${response!.statusCode}\n${super.stackTrace ?? ''}}';
    }
    return super.toString();
  }
}

class LocalStorageException extends AppException {
  LocalStorageException({super.message, super.stackTrace});
}

class NoInternetConnectionException extends AppException {
  NoInternetConnectionException({
    super.message = AppMessages.noInternetConnection,
  });
}

class EmptyResultException extends AppException {
  EmptyResultException({super.message = AppMessages.emptyResult});
}
