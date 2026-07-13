import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class DioClient {
  final Dio dio;

  DioClient._(this.dio);

  factory DioClient.create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: const {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        requestBody: false,
        responseBody: false,
        logPrint: (_) {}, // no-op in production; swap for a real logger
      ),
    );

    return DioClient._(dio);
  }
}
