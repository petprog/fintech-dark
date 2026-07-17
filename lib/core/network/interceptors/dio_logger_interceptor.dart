import 'package:dio/dio.dart';
import 'package:fintech_dark/core/logger/app_logger.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DioLoggerInterceptor extends Interceptor {
  final AppLogger logger;

  DioLoggerInterceptor(this.logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.debug('''
REQUEST
${options.method} ${options.uri}
''');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.debug('''
RESPONSE
${response.statusCode}
''');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.error('API request failed', error: err, stackTrace: err.stackTrace);

    handler.next(err);
  }
}
