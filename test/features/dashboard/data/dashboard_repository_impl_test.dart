import 'package:dartz/dartz.dart';
import 'package:fintech_dark/core/core.dart';
import 'package:fintech_dark/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDatasource extends Mock implements DashboardRemoteDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class FakeDashboardModel extends Fake implements DashboardModel {}

void main() {
  late MockRemoteDatasource remoteDatasource;
  late MockNetworkInfo networkInfo;
  late DashboardRepositoryImpl repository;

  final tModel = DashboardModel(
    userName: 'Tayyab Sohail',
    email: 'tayyabsohailabd@gmail.com',
    totalBalance: 1200,
    totalSpending: 1200,
    spendingTrend: const [SpendingPointModel(month: 'Jan', value: 900)],
    cards: const [],
    quickActions: const [],
    transactions: const [],
    lastUpdated: DateTime.fromMillisecondsSinceEpoch(0),
  );

  final tEntity = tModel.toEntity();

  setUpAll(() {
    registerFallbackValue(FakeDashboardModel());
  });

  setUp(() {
    remoteDatasource = MockRemoteDatasource();
    networkInfo = MockNetworkInfo();

    when(() => networkInfo.isConnected).thenAnswer((_) async => true);

    repository = DashboardRepositoryImpl(
      remoteDatasource: remoteDatasource,
      networkInfo: networkInfo,
    );
  });

  group('getDashboard', () {
    test(
      'returns NetworkFailure when offline, without hitting the datasource',
      () async {
        when(() => networkInfo.isConnected).thenAnswer((_) async => false);

        final result = await repository.getDashboard();

        expect(result, isA<Left<Failure, dynamic>>());
        expect(result.fold((f) => f, (_) => null), isA<NetworkFailure>());
        verifyNever(() => remoteDatasource.getDashboard());
      },
    );

    test(
      'returns Right(DashboardEntity) when the datasource succeeds',
      () async {
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        when(
          () => remoteDatasource.getDashboard(),
        ).thenAnswer((_) async => tModel);

        final result = await repository.getDashboard();

        expect(result, Right(tEntity));
      },
    );

    test('maps ServerException to ServerFailure', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => remoteDatasource.getDashboard(),
      ).thenThrow(const ServerException('down'));

      final result = await repository.getDashboard();

      expect(result, const Left(ServerFailure('down')));
    });

    test('maps NetworkException to NetworkFailure with message', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => remoteDatasource.getDashboard(),
      ).thenThrow(const NetworkException('timed out'));

      final result = await repository.getDashboard();

      expect(result, const Left(NetworkFailure('timed out')));
    });

    test('maps an unexpected exception to UnknownFailure', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => remoteDatasource.getDashboard(),
      ).thenThrow(Exception('unexpected'));

      final result = await repository.getDashboard();

      expect(result, const Left(UnknownFailure()));
    });
  });

  group('watchDashboardUpdates', () {
    test('yields Right updates from the datasource stream', () async {
      when(
        () => remoteDatasource.watchDashboardUpdates(any()),
      ).thenAnswer((_) => Stream.value(tModel));

      final result = await repository.watchDashboardUpdates(tEntity).first;

      expect(result, Right(tEntity));
    });

    test('yields multiple Right updates in order', () async {
      final secondModel = tModel.copyWith(totalBalance: 1300);

      when(
        () => remoteDatasource.watchDashboardUpdates(any()),
      ).thenAnswer((_) => Stream.fromIterable([tModel, secondModel]));

      final results = await repository.watchDashboardUpdates(tEntity).toList();

      expect(results, [Right(tEntity), Right(secondModel.toEntity())]);
    });

    test(
      'yields ServerFailure when datasource stream throws ServerException',
      () async {
        when(() => remoteDatasource.watchDashboardUpdates(any())).thenAnswer(
          (_) => Stream<DashboardModel>.error(const ServerException('drop')),
        );

        final result = await repository.watchDashboardUpdates(tEntity).first;

        expect(result, const Left(ServerFailure('drop')));
      },
    );

    test(
      'yields UnknownFailure when datasource stream throws unexpectedly',
      () async {
        when(
          () => remoteDatasource.watchDashboardUpdates(any()),
        ).thenAnswer((_) => Stream<DashboardModel>.error(Exception('boom')));

        final result = await repository.watchDashboardUpdates(tEntity).first;

        expect(result, const Left(UnknownFailure()));
      },
    );

    test(
      'converts DashboardEntity into DashboardModel before datasource call',
      () async {
        when(
          () => remoteDatasource.watchDashboardUpdates(any()),
        ).thenAnswer((_) => Stream.value(tModel));

        await repository.watchDashboardUpdates(tEntity).first;

        final captured =
            verify(
                  () => remoteDatasource.watchDashboardUpdates(captureAny()),
                ).captured.single
                as DashboardModel;

        expect(captured.userName, tEntity.userName);
        expect(captured.totalBalance, tEntity.totalBalance);
        expect(captured.lastUpdated, tEntity.lastUpdated);
      },
    );
  });

  group('toggleFreezeCard', () {
    test(
      'returns NetworkFailure when offline, without hitting the datasource',
      () async {
        when(() => networkInfo.isConnected).thenAnswer((_) async => false);

        final result = await repository.toggleFreezeCard(
          cardId: 'card_1',
          freeze: true,
        );

        expect(result, const Left(NetworkFailure()));
        verifyNever(
          () => remoteDatasource.toggleFreezeCard(
            cardId: any(named: 'cardId'),
            freeze: any(named: 'freeze'),
          ),
        );
      },
    );

    test('returns Right(CardEntity) on success', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => remoteDatasource.toggleFreezeCard(cardId: 'card_1', freeze: true),
      ).thenAnswer(
        (_) async => const CardModel(
          id: 'card_1',
          holderName: 'Tayyab Sohail',
          maskedNumber: '•••• 3466',
          validThru: '12/02/2024',
          cvv: '663',
          isVirtual: false,
          isFrozen: true,
        ),
      );

      final result = await repository.toggleFreezeCard(
        cardId: 'card_1',
        freeze: true,
      );

      expect(result.isRight(), true);
    });

    test('maps ServerException to ServerFailure', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => remoteDatasource.toggleFreezeCard(cardId: 'card_1', freeze: true),
      ).thenThrow(const ServerException('card locked'));

      final result = await repository.toggleFreezeCard(
        cardId: 'card_1',
        freeze: true,
      );

      expect(result, const Left(ServerFailure('card locked')));
    });

    test('maps an unexpected exception to UnknownFailure', () async {
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => remoteDatasource.toggleFreezeCard(cardId: 'card_1', freeze: true),
      ).thenThrow(Exception('unexpected'));

      final result = await repository.toggleFreezeCard(
        cardId: 'card_1',
        freeze: true,
      );

      expect(result, const Left(UnknownFailure()));
    });
  });
}
