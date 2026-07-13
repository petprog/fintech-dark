import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../network/network_info.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient.create());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
}
