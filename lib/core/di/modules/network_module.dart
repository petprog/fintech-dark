import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../core.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio provideDio(
    AppConfig config,
    AuthInterceptor authInterceptor,
    ErrorInterceptor errorInterceptor,
    DioLoggerInterceptor dioLoggerInterceptor,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.addAll([
      authInterceptor,
      errorInterceptor,
      dioLoggerInterceptor,
    ]);

    return dio;
  }
}
