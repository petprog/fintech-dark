// import 'package:dartz/dartz.dart';
// import 'package:injectable/injectable.dart';

// import '../../../../core/core.dart';
// import '../../../features.dart';

// @LazySingleton(as: DashboardRepository)
// class DashboardRepositoryImpl
//     with RemoteGuard, LocalGuard
//     implements DashboardRepository {
//   @override
//   final NetworkInfo networkInfo;

//   final DashboardRemoteDatasource remoteDatasource;
//   final DashboardLocalDatasource localDatasource;

//   DashboardRepositoryImpl({
//     required this.remoteDatasource,
//     required this.localDatasource,
//     required this.networkInfo,
//   });

//   @override
//   Future<Either<Failure, DashboardEntity>> getDashboard() async {
//     final localResult = await localGuard(() => localDatasource.getDashboard());

//     return localResult.fold(
//       (_) async {
//         final remoteResult = await remoteGuard(
//           () => remoteDatasource.getDashboard(),
//         );

//         return remoteResult.fold(Left.new, (model) async {
//           await localGuard(() => localDatasource.saveDashboard(model));

//           return Right(model.toEntity());
//         });
//       },
//       (model) {
//         return Right(model.toEntity());
//       },
//     );
//   }

//   @override
//   Future<Either<Failure, CardEntity>> toggleFreezeCard({
//     required String cardId,
//     required bool freeze,
//   }) async {
//     final result = await remoteGuard(
//       () => remoteDatasource.toggleFreezeCard(cardId: cardId, freeze: freeze),
//     );

//     return result.fold(Left.new, (model) async {
//       await localGuard(() => localDatasource.updateCard(model));

//       return Right(model.toEntity());
//     });
//   }

//   @override
//   Stream<Either<Failure, DashboardEntity>> watchDashboardUpdates(
//     DashboardEntity current,
//   ) {
//     return remoteGuardStream(
//       () => remoteDatasource
//           .watchDashboardUpdates(current.toModel())
//           .map((model) => model.toEntity()),
//     );
//   }
// }
