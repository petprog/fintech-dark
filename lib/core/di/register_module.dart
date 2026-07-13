import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../network/dio_client.dart';
import '../constants/api_constants.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  DioClient get dioClient {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: const {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      LogInterceptor(requestBody: false, responseBody: false, logPrint: (_) {}),
    );

    return DioClient(dio);
  }
}
