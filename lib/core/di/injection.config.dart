// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i141;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce_flutter/hive_ce_flutter.dart' as _i965;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/dashboard/data/datasource/dashboard_remote_datasource.dart'
    as _i454;
import '../../features/dashboard/data/repository/dashboard_repository_impl.dart'
    as _i604;
import '../../features/dashboard/domain/repositories/dashboard_repository.dart'
    as _i665;
import '../../features/dashboard/domain/usecases/get_dashboard_usecase.dart'
    as _i803;
import '../../features/dashboard/domain/usecases/toggle_freeze_card_usecase.dart'
    as _i875;
import '../../features/dashboard/domain/usecases/watch_dashboard_updates_usecase.dart'
    as _i1027;
import '../../features/dashboard/presentation/bloc/card_settings_cubit.dart'
    as _i531;
import '../../features/dashboard/presentation/bloc/dashboard_cubit.dart'
    as _i58;
import '../../features/features.dart' as _i233;
import '../core.dart' as _i351;
import '../logger/app_logger.dart' as _i293;
import '../logger/logger_impl.dart' as _i200;
import '../logger/trees/log_tree.dart' as _i757;
import '../network/dio_client.dart' as _i667;
import '../network/interceptors/auth_interceptor.dart' as _i745;
import '../network/interceptors/dio_logger_interceptor.dart' as _i1005;
import '../network/interceptors/error_interceptor.dart' as _i511;
import '../network/interceptors/logger_interceptor.dart' as _i238;
import '../network/network_info.dart' as _i932;
import '../security/token_storage.dart' as _i77;
import '../security/token_storage_impl.dart' as _i971;
import 'modules/app_config_module.dart' as _i276;
import 'modules/connectivity_module.dart' as _i855;
import 'modules/firebase_module.dart' as _i398;
import 'modules/hive_module.dart' as _i31;
import 'modules/logger_module.dart' as _i205;
import 'modules/network_module.dart' as _i851;
import 'modules/security_module.dart' as _i455;
import 'modules/storage_module.dart' as _i148;

const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    final connectivityModule = _$ConnectivityModule();
    final firebaseModule = _$FirebaseModule();
    final loggerModule = _$LoggerModule();
    final securityModule = _$SecurityModule();
    final appConfigModule = _$AppConfigModule();
    final hiveModule = _$HiveModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.provideSharedPreferences(),
      preResolve: true,
    );
    gh.factory<_i531.CardSettingsCubit>(() => _i531.CardSettingsCubit());
    gh.lazySingleton<_i895.Connectivity>(
      () => connectivityModule.provideConnectivity(),
    );
    gh.lazySingleton<_i141.FirebaseCrashlytics>(
      () => firebaseModule.provideFirebaseCrashlytics(),
    );
    gh.lazySingleton<_i351.ConsoleLogTree>(() => loggerModule.consoleLogTree());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => securityModule.provideSecureStorage(),
    );
    gh.lazySingleton<_i511.ErrorInterceptor>(() => _i511.ErrorInterceptor());
    gh.lazySingleton<_i238.LoggerInterceptor>(() => _i238.LoggerInterceptor());
    gh.singleton<_i351.AppConfig>(
      () => appConfigModule.devConfig,
      registerFor: {_dev},
    );
    gh.lazySingleton<_i77.TokenStorage>(
      () => _i971.TokenStorageImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i745.AuthInterceptor>(
      () => _i745.AuthInterceptor(gh<_i351.TokenStorage>()),
    );
    gh.lazySingleton<_i932.NetworkInfo>(
      () => _i932.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    await gh.singletonAsync<List<int>>(
      () => hiveModule.hiveEncryptionKey(gh<_i558.FlutterSecureStorage>()),
      instanceName: 'hiveEncryptionKey',
      preResolve: true,
    );
    await gh.factoryAsync<_i965.Box<_i351.WalletModel>>(
      () => hiveModule.walletBox(
        gh<List<int>>(instanceName: 'hiveEncryptionKey'),
      ),
      instanceName: 'walletBox',
      preResolve: true,
    );
    gh.singleton<_i351.AppConfig>(
      () => appConfigModule.prodConfig,
      registerFor: {_prod},
    );
    gh.lazySingleton<_i351.CrashlyticsLogTree>(
      () => loggerModule.crashlyticsLogTree(gh<_i141.FirebaseCrashlytics>()),
    );
    await gh.factoryAsync<_i965.Box<_i351.AccountModel>>(
      () => hiveModule.accountBox(
        gh<List<int>>(instanceName: 'hiveEncryptionKey'),
      ),
      instanceName: 'accountBox',
      preResolve: true,
    );
    gh.lazySingleton<List<_i351.LogTree>>(
      () => loggerModule.logTrees(
        gh<_i351.ConsoleLogTree>(),
        gh<_i351.CrashlyticsLogTree>(),
      ),
    );
    gh.lazySingleton<_i293.AppLogger>(
      () => _i200.LoggerImpl(gh<List<_i757.LogTree>>()),
    );
    gh.lazySingleton<_i1005.DioLoggerInterceptor>(
      () => _i1005.DioLoggerInterceptor(gh<_i293.AppLogger>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.provideDio(
        gh<_i351.AppConfig>(),
        gh<_i351.AuthInterceptor>(),
        gh<_i351.ErrorInterceptor>(),
        gh<_i351.DioLoggerInterceptor>(),
      ),
    );
    gh.lazySingleton<_i667.DioClient>(() => _i667.DioClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i454.DashboardRemoteDatasource>(
      () => _i454.DashboardRemoteDatasourceImpl(gh<_i351.DioClient>()),
    );
    gh.lazySingleton<_i233.DashboardRepository>(
      () => _i604.DashboardRepositoryImpl(
        remoteDatasource: gh<_i233.DashboardRemoteDatasource>(),
        networkInfo: gh<_i351.NetworkInfo>(),
      ),
    );
    gh.factory<_i803.GetDashboardUsecase>(
      () => _i803.GetDashboardUsecase(gh<_i665.DashboardRepository>()),
    );
    gh.factory<_i875.ToggleFreezeCardUsecase>(
      () => _i875.ToggleFreezeCardUsecase(gh<_i233.DashboardRepository>()),
    );
    gh.factory<_i1027.WatchDashboardUpdatesUsecase>(
      () =>
          _i1027.WatchDashboardUpdatesUsecase(gh<_i665.DashboardRepository>()),
    );
    gh.factory<_i58.DashboardCubit>(
      () => _i58.DashboardCubit(
        getDashboardUsecase: gh<_i233.GetDashboardUsecase>(),
        watchDashboardUpdatesUsecase: gh<_i233.WatchDashboardUpdatesUsecase>(),
        toggleFreezeCardUsecase: gh<_i233.ToggleFreezeCardUsecase>(),
      ),
    );
    return this;
  }
}

class _$StorageModule extends _i148.StorageModule {}

class _$ConnectivityModule extends _i855.ConnectivityModule {}

class _$FirebaseModule extends _i398.FirebaseModule {}

class _$LoggerModule extends _i205.LoggerModule {}

class _$SecurityModule extends _i455.SecurityModule {}

class _$AppConfigModule extends _i276.AppConfigModule {}

class _$HiveModule extends _i31.HiveModule {}

class _$NetworkModule extends _i851.NetworkModule {}
