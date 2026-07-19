import 'package:dartz/dartz.dart';

import '../core.dart';

mixin RemoteGuard {
  NetworkInfo get networkInfo;

  Future<Either<Failure, T>> remoteGuard<T>(Future<T> Function() action) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      return Right(await action());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  Stream<Either<Failure, T>> remoteGuardStream<T>(
    Stream<T> Function() action,
  ) async* {
    if (!await networkInfo.isConnected) {
      yield const Left(NetworkFailure());
      return;
    }

    try {
      await for (final value in action()) {
        yield Right(value);
      }
    } on ServerException catch (e) {
      yield Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      yield Left(NetworkFailure(e.message));
    } catch (_) {
      yield const Left(UnknownFailure());
    }
  }
}
