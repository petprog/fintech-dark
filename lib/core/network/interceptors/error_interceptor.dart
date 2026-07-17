import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        break;

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;

        if (statusCode == 401) {}

        break;

      default:
        break;
    }

    handler.next(err);
  }
}
