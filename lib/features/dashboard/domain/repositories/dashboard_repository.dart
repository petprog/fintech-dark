import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../features.dart';

abstract interface class DashboardRepository {
  Future<Either<Failure, DashboardEntity>> getDashboard();

  Stream<Either<Failure, DashboardEntity>> watchDashboardUpdates(
    DashboardEntity current,
  );

  Future<Either<Failure, CardEntity>> toggleFreezeCard({
    required String cardId,
    required bool freeze,
  });
}
