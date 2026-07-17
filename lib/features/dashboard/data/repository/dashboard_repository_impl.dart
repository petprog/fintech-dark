import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

@LazySingleton(as: DashboardRepository)
@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl with NetworkGuard implements DashboardRepository {
  @override
  final NetworkInfo networkInfo;
  final DashboardRemoteDatasource remoteDatasource;

  DashboardRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DashboardEntity>> getDashboard() =>
      guard(() async => (await remoteDatasource.getDashboard()).toEntity());

  @override
  Future<Either<Failure, CardEntity>> toggleFreezeCard({
    required String cardId,
    required bool freeze,
  }) => guard(
    () async => (await remoteDatasource.toggleFreezeCard(
      cardId: cardId,
      freeze: freeze,
    )).toEntity(),
  );

  @override
  Stream<Either<Failure, DashboardEntity>> watchDashboardUpdates(
    DashboardEntity current,
  ) => guardStream(
    () => remoteDatasource
        .watchDashboardUpdates(current.toModel())
        .map((m) => m.toEntity()),
  );
}
