// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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
import '../network/dio_client.dart' as _i667;
import '../network/network_info.dart' as _i932;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i531.CardSettingsCubit>(() => _i531.CardSettingsCubit());
    gh.lazySingleton<_i667.DioClient>(() => registerModule.dioClient);
    gh.lazySingleton<_i932.NetworkInfo>(() => _i932.NetworkInfoImpl());
    gh.lazySingleton<_i454.DashboardRemoteDatasource>(
      () => _i454.DashboardRemoteDatasourceImpl(gh<_i351.DioClient>()),
    );
    gh.lazySingleton<_i233.DashboardRepository>(
      () => _i604.DashboardRepositoryImpl(
        remoteDatasource: gh<_i233.DashboardRemoteDatasource>(),
        networkInfo: gh<_i932.NetworkInfo>(),
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

class _$RegisterModule extends _i291.RegisterModule {}
