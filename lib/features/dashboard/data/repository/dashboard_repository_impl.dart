import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

@LazySingleton(as: DashboardRepository)
@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl with RemoteGuard implements DashboardRepository {
  @override
  final NetworkInfo networkInfo;
  final DashboardRemoteDatasource remoteDatasource;

  DashboardRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });

  // Model structure of data for the API, Database, Local Storage
  // Entity structure of data for UI, Usecases
  // Usecase
  // Future<Either<Failure, ProfileEntity>> updateProfile(ProfileEntity request)
  // Future<ProfileModel>> updateProfile(UpdateProfileModel request)  EntityWrapper that ProfileEnity to UpdateProfileModel (based on what need to be updated) and ModelWrapper that ProfileModel (what is returned from json) to ProfileEntity

  // Future<Either<Failure, ProfileEntity>> updateProfile(ProfileEntity request)
  // Future<ProfileModel>> getProfile()
  // Any conversion from Entity to Model vice-versa happens repository

  // first and last name.       (..Entity request)        datasource.update(...Entity request)         dioClient.patch(request.toModel())        dioClient.patch(request.toJson())
  // Update Request  UI ->   UpdateProfileRequestEntity    -> UpdateProfileUsecase ->                        ProfileRepository                   ->     ProfileRemoteDatasource                   -> UpdateProfileRequestModel

  // DataResponse UI <- UpdateProfileResponseEntity <- UpdateProfileUsecase <- ProfileRepository <-  ProfileDatasource <- UpdateProfileResponseModel

  @override
  Future<Either<Failure, DashboardEntity>> getDashboard() => remoteGuard(
    () async => (await remoteDatasource.getDashboard()).toEntity(),
  );

  @override
  Future<Either<Failure, CardEntity>> toggleFreezeCard({
    required String cardId,
    required bool freeze,
  }) => remoteGuard(
    () async => (await remoteDatasource.toggleFreezeCard(
      cardId: cardId,
      freeze: freeze,
    )).toEntity(),
  );

  @override
  Stream<Either<Failure, DashboardEntity>> watchDashboardUpdates(
    DashboardEntity current,
  ) => remoteGuardStream(
    () => remoteDatasource
        .watchDashboardUpdates(current.toModel())
        .map((m) => m.toEntity()),
  );
}
