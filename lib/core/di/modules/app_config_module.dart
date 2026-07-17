import 'package:injectable/injectable.dart';

import '../../core.dart';

@module
abstract class AppConfigModule {
  @dev
  @singleton
  AppConfig get devConfig {
    return const AppConfig(baseUrl: 'https://dev-api.com');
  }

  @prod
  @singleton
  AppConfig get prodConfig {
    return const AppConfig(baseUrl: 'https://api.com');
  }
}
