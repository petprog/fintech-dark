import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../features.dart';

@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  DashboardRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DashboardEntity>> getDashboard() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final model = await remoteDatasource.getDashboard();
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Stream<Either<Failure, DashboardEntity>> watchDashboardUpdates(
    DashboardEntity current,
  ) async* {
    final currentModel = current.toModel();

    try {
      await for (final update in remoteDatasource.watchDashboardUpdates(
        currentModel,
      )) {
        yield Right(update.toEntity());
      }
    } on ServerException catch (e) {
      yield Left(ServerFailure(e.message));
    } catch (_) {
      yield const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, CardEntity>> toggleFreezeCard({
    required String cardId,
    required bool freeze,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      final model = await remoteDatasource.toggleFreezeCard(
        cardId: cardId,
        freeze: freeze,
      );
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
