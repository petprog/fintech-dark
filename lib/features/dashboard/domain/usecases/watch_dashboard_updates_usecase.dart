import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/dashboard_entity.dart';
import '../repositories/dashboard_repository.dart';

@injectable
class WatchDashboardUpdatesUsecase {
  final DashboardRepository repository;

  const WatchDashboardUpdatesUsecase(this.repository);

  Stream<Either<Failure, DashboardEntity>> call(DashboardEntity current) {
    return repository.watchDashboardUpdates(current);
  }
}
