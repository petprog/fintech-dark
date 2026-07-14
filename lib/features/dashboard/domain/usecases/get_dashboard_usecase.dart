import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/dashboard_entity.dart';
import '../repositories/dashboard_repository.dart';

@injectable
class GetDashboardUsecase {
  final DashboardRepository repository;

  const GetDashboardUsecase(this.repository);

  Future<Either<Failure, DashboardEntity>> call() {
    return repository.getDashboard();
  }
}
