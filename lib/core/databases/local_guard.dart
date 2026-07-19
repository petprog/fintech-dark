import 'package:dartz/dartz.dart';

import '../core.dart';

mixin LocalGuard {
  Future<Either<Failure, T>> localGuard<T>(Future<T> Function() action) async {
    try {
      return Right(await action());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
