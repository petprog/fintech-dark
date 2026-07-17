import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../core.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio provideDio(AppConfig config) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }
}
