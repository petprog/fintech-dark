import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fintech_dark/core/core.dart';
import 'package:fintech_dark/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDashboardUsecase extends Mock implements GetDashboardUsecase {}

class MockWatchDashboardUpdatesUsecase extends Mock
    implements WatchDashboardUpdatesUsecase {}

class MockToggleFreezeCardUsecase extends Mock
    implements ToggleFreezeCardUsecase {}

void main() {
  late MockGetDashboardUsecase getDashboardUsecase;
  late MockWatchDashboardUpdatesUsecase watchDashboardUpdatesUsecase;
  late MockToggleFreezeCardUsecase toggleFreezeCardUsecase;
  late DashboardCubit cubit;

  final tDashboard = DashboardEntity(
    userName: 'Tayyab Sohail',
    email: 'tayyabsohailabd@gmail.com',
    totalBalance: 1200,
    totalSpending: 1200,
    spendingTrend: const [SpendingPointEntity(month: 'Jan', value: 900)],
    cards: const [
      CardEntity(
        id: 'card_1',
        holderName: 'Tayyab Sohail',
        maskedNumber: '•••• 3466',
        validThru: '12/02/2024',
        cvv: '663',
        isVirtual: false,
      ),
      CardEntity(
        id: 'card_2',
        holderName: 'Tayyab Sohail',
        maskedNumber: '•••• 9911',
        validThru: '01/01/2026',
        cvv: '321',
        isVirtual: true,
        isFrozen: true,
      ),
    ],
    quickActions: const [
      QuickActionEntity(
        id: 'bill_pay',
        label: 'Bill Pay',
        iconName: 'bill_pay',
      ),
    ],
    transactions: const [],
    lastUpdated: DateTime.fromMillisecondsSinceEpoch(0),
  );

  setUpAll(() {
    registerFallbackValue(tDashboard);
  });

  setUp(() {
    getDashboardUsecase = MockGetDashboardUsecase();
    watchDashboardUpdatesUsecase = MockWatchDashboardUpdatesUsecase();
    toggleFreezeCardUsecase = MockToggleFreezeCardUsecase();

    when(
      () => watchDashboardUpdatesUsecase(any()),
    ).thenAnswer((_) => const Stream.empty());

    cubit = DashboardCubit(
      getDashboardUsecase: getDashboardUsecase,
      watchDashboardUpdatesUsecase: watchDashboardUpdatesUsecase,
      toggleFreezeCardUsecase: toggleFreezeCardUsecase,
    );
  });

  tearDown(() => cubit.close());

  test('initial state is DashboardInitial', () {
    expect(cubit.state, const DashboardInitial());
  });

  group('DashboardState equality', () {
    test('DashboardLoaded copyWith preserves unspecified fields', () {
      final loaded = DashboardLoaded(dashboard: tDashboard, isLive: true);
      final copy = loaded.copyWith(isRefreshing: true);

      expect(copy.dashboard, tDashboard);
      expect(copy.isLive, true);
      expect(copy.isRefreshing, true);
    });

    test('two DashboardLoaded with same props are equal', () {
      expect(
        DashboardLoaded(dashboard: tDashboard),
        DashboardLoaded(dashboard: tDashboard),
      );
    });

    test('DashboardError without lastKnownGood differs from one with it', () {
      expect(
        const DashboardError('x'),
        isNot(DashboardError('x', lastKnownGood: tDashboard)),
      );
    });
  });

  group('loadDashboard', () {
    blocTest<DashboardCubit, DashboardState>(
      'emits [Loading, Loaded] when the usecase succeeds',
      build: () {
        when(
          () => getDashboardUsecase(),
        ).thenAnswer((_) async => Right(tDashboard));
        return cubit;
      },
      act: (c) => c.loadDashboard(),
      expect: () => [
        const DashboardLoading(),
        DashboardLoaded(dashboard: tDashboard),
      ],
    );

    blocTest<DashboardCubit, DashboardState>(
      'emits [Loading, Error] when the usecase fails',
      build: () {
        when(
          () => getDashboardUsecase(),
        ).thenAnswer((_) async => const Left(ServerFailure('boom')));
        return cubit;
      },
      act: (c) => c.loadDashboard(),
      expect: () => [const DashboardLoading(), const DashboardError('boom')],
    );

    blocTest<DashboardCubit, DashboardState>(
      'emits [Loading, Error] with no lastKnownGood on the very first load',
      build: () {
        when(
          () => getDashboardUsecase(),
        ).thenAnswer((_) async => const Left(NetworkFailure('offline')));
        return cubit;
      },
      act: (c) => c.loadDashboard(),
      verify: (c) {
        final state = c.state;
        expect(state, isA<DashboardError>());
        expect((state as DashboardError).lastKnownGood, isNull);
      },
    );

    blocTest<DashboardCubit, DashboardState>(
      'subscribes to real-time updates after a successful load',
      build: () {
        when(
          () => getDashboardUsecase(),
        ).thenAnswer((_) async => Right(tDashboard));
        final updated = tDashboard.copyWith(totalBalance: 1250);
        when(
          () => watchDashboardUpdatesUsecase(any()),
        ).thenAnswer((_) => Stream.value(Right(updated)));
        return cubit;
      },
      act: (c) => c.loadDashboard(),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const DashboardLoading(),
        DashboardLoaded(dashboard: tDashboard),
        isA<DashboardLoaded>()
            .having((s) => s.dashboard.totalBalance, 'totalBalance', 1250)
            .having((s) => s.isLive, 'isLive', true),
      ],
    );

    blocTest<DashboardCubit, DashboardState>(
      'applies multiple sequential real-time ticks in order',
      build: () {
        when(
          () => getDashboardUsecase(),
        ).thenAnswer((_) async => Right(tDashboard));
        when(() => watchDashboardUpdatesUsecase(any())).thenAnswer(
          (_) => Stream.fromIterable([
            Right(tDashboard.copyWith(totalBalance: 1300)),
            Right(tDashboard.copyWith(totalBalance: 1400)),
          ]),
        );
        return cubit;
      },
      act: (c) => c.loadDashboard(),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const DashboardLoading(),
        DashboardLoaded(dashboard: tDashboard),
        isA<DashboardLoaded>().having(
          (s) => s.dashboard.totalBalance,
          'totalBalance',
          1300,
        ),
        isA<DashboardLoaded>().having(
          (s) => s.dashboard.totalBalance,
          'totalBalance',
          1400,
        ),
      ],
    );

    blocTest<DashboardCubit, DashboardState>(
      'ignores a failed real-time tick (does not emit or crash)',
      build: () {
        when(
          () => getDashboardUsecase(),
        ).thenAnswer((_) async => Right(tDashboard));
        when(() => watchDashboardUpdatesUsecase(any())).thenAnswer(
          (_) => Stream.value(const Left(ServerFailure('socket dropped'))),
        );
        return cubit;
      },
      act: (c) => c.loadDashboard(),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        const DashboardLoading(),
        DashboardLoaded(dashboard: tDashboard),
      ],
    );

    blocTest<DashboardCubit, DashboardState>(
      'cancels the previous real-time subscription when loadDashboard is called again',
      build: () {
        when(
          () => getDashboardUsecase(),
        ).thenAnswer((_) async => Right(tDashboard));
        return cubit;
      },
      act: (c) async {
        final firstController =
            StreamController<Either<Failure, DashboardEntity>>();
        final secondController =
            StreamController<Either<Failure, DashboardEntity>>();

        var callCount = 0;
        when(() => watchDashboardUpdatesUsecase(any())).thenAnswer((_) {
          callCount++;
          return callCount == 1
              ? firstController.stream
              : secondController.stream;
        });

        await c.loadDashboard();
        await c.loadDashboard();
        firstController.add(Right(tDashboard.copyWith(totalBalance: 42)));
        await Future<void>.delayed(Duration.zero);

        await firstController.close();
        await secondController.close();
      },
      expect: () => [
        const DashboardLoading(),
        DashboardLoaded(dashboard: tDashboard),
        const DashboardLoading(),
        DashboardLoaded(dashboard: tDashboard),
      ],
    );
  });

  group('refresh', () {
    blocTest<DashboardCubit, DashboardState>(
      'emits [refreshing=true, Loaded] when refresh succeeds from a loaded state',
      build: () {
        final refreshed = tDashboard.copyWith(totalBalance: 1500);
        when(
          () => getDashboardUsecase(),
        ).thenAnswer((_) async => Right(refreshed));
        return cubit;
      },
      seed: () => DashboardLoaded(dashboard: tDashboard),
      act: (c) => c.refresh(),
      expect: () => [
        DashboardLoaded(dashboard: tDashboard, isRefreshing: true),
        isA<DashboardLoaded>()
            .having((s) => s.dashboard.totalBalance, 'totalBalance', 1500)
            .having((s) => s.isRefreshing, 'isRefreshing', false),
      ],
    );

    blocTest<DashboardCubit, DashboardState>(
      'emits [Loading, Loaded] when refresh is called from a non-loaded state',
      build: () {
        when(
          () => getDashboardUsecase(),
        ).thenAnswer((_) async => Right(tDashboard));
        return cubit;
      },
      act: (c) => c.refresh(),
      expect: () => [
        const DashboardLoading(),
        DashboardLoaded(dashboard: tDashboard),
      ],
    );

    blocTest<DashboardCubit, DashboardState>(
      'preserves lastKnownGood snapshot when refresh fails',
      build: () {
        when(
          () => getDashboardUsecase(),
        ).thenAnswer((_) async => Right(tDashboard));
        return cubit;
      },
      seed: () => DashboardLoaded(dashboard: tDashboard),
      act: (c) async {
        when(
          () => getDashboardUsecase(),
        ).thenAnswer((_) async => const Left(NetworkFailure('offline')));
        await c.refresh();
      },
      expect: () => [
        DashboardLoaded(dashboard: tDashboard, isRefreshing: true),
        DashboardError('offline', lastKnownGood: tDashboard),
      ],
    );

    blocTest<DashboardCubit, DashboardState>(
      'refresh has no lastKnownGood when it fails from a non-loaded state',
      build: () {
        when(
          () => getDashboardUsecase(),
        ).thenAnswer((_) async => const Left(ServerFailure('boom')));
        return cubit;
      },
      act: (c) => c.refresh(),
      verify: (c) {
        final state = c.state;
        expect(state, isA<DashboardError>());
        expect((state as DashboardError).lastKnownGood, isNull);
      },
    );

    blocTest<DashboardCubit, DashboardState>(
      'starts real-time updates again after a successful refresh',
      build: () {
        when(
          () => getDashboardUsecase(),
        ).thenAnswer((_) async => Right(tDashboard));
        final updated = tDashboard.copyWith(totalBalance: 1600);
        when(
          () => watchDashboardUpdatesUsecase(any()),
        ).thenAnswer((_) => Stream.value(Right(updated)));
        return cubit;
      },
      seed: () => DashboardLoaded(dashboard: tDashboard),
      act: (c) => c.refresh(),
      wait: const Duration(milliseconds: 50),
      expect: () => [
        DashboardLoaded(dashboard: tDashboard, isRefreshing: true),
        DashboardLoaded(dashboard: tDashboard),
        isA<DashboardLoaded>()
            .having((s) => s.dashboard.totalBalance, 'totalBalance', 1600)
            .having((s) => s.isLive, 'isLive', true),
      ],
    );
  });

  group('toggleFreezeCard', () {
    blocTest<DashboardCubit, DashboardState>(
      'updates the matching card in place on success (freeze)',
      build: () {
        when(
          () => toggleFreezeCardUsecase(cardId: 'card_1', freeze: true),
        ).thenAnswer(
          (_) async => Right(tDashboard.cards.first.copyWith(isFrozen: true)),
        );
        return cubit;
      },
      seed: () => DashboardLoaded(dashboard: tDashboard),
      act: (c) => c.toggleFreezeCard('card_1'),
      expect: () => [
        isA<DashboardLoaded>().having(
          (s) => s.dashboard.cards.first.isFrozen,
          'isFrozen',
          true,
        ),
      ],
    );

    blocTest<DashboardCubit, DashboardState>(
      'calls the usecase with freeze:false when the card is already frozen',
      build: () {
        when(
          () => toggleFreezeCardUsecase(cardId: 'card_2', freeze: false),
        ).thenAnswer(
          (_) async => Right(tDashboard.cards[1].copyWith(isFrozen: false)),
        );
        return cubit;
      },
      seed: () => DashboardLoaded(dashboard: tDashboard),
      act: (c) => c.toggleFreezeCard('card_2'),
      verify: (c) {
        verify(
          () => toggleFreezeCardUsecase(cardId: 'card_2', freeze: false),
        ).called(1);
      },
      expect: () => [
        isA<DashboardLoaded>().having(
          (s) => s.dashboard.cards[1].isFrozen,
          'isFrozen',
          false,
        ),
      ],
    );

    blocTest<DashboardCubit, DashboardState>(
      'leaves other cards untouched when one is toggled',
      build: () {
        when(
          () => toggleFreezeCardUsecase(cardId: 'card_1', freeze: true),
        ).thenAnswer(
          (_) async => Right(tDashboard.cards.first.copyWith(isFrozen: true)),
        );
        return cubit;
      },
      seed: () => DashboardLoaded(dashboard: tDashboard),
      act: (c) => c.toggleFreezeCard('card_1'),
      expect: () => [
        isA<DashboardLoaded>().having(
          (s) => s.dashboard.cards[1].isFrozen,
          'card_2 unaffected',
          true,
        ),
      ],
    );

    blocTest<DashboardCubit, DashboardState>(
      'emits nothing when the usecase fails',
      build: () {
        when(
          () => toggleFreezeCardUsecase(cardId: 'card_1', freeze: true),
        ).thenAnswer(
          (_) async => const Left(ServerFailure('failed to toggle')),
        );
        return cubit;
      },
      seed: () => DashboardLoaded(dashboard: tDashboard),
      act: (c) => c.toggleFreezeCard('card_1'),
      expect: () => [],
    );

    blocTest<DashboardCubit, DashboardState>(
      'does nothing when the current state is not DashboardLoaded',
      build: () => cubit,
      act: (c) => c.toggleFreezeCard('card_1'),
      expect: () => [],
    );

    blocTest<DashboardCubit, DashboardState>(
      'does nothing when the current state is DashboardError',
      build: () => cubit,
      seed: () => const DashboardError('boom'),
      act: (c) => c.toggleFreezeCard('card_1'),
      expect: () => [],
    );
  });

  group('close', () {
    test(
      'cancels the real-time subscription so no further emissions occur',
      () async {
        when(
          () => getDashboardUsecase(),
        ).thenAnswer((_) async => Right(tDashboard));
        final controller = StreamController<Either<Failure, DashboardEntity>>();
        when(
          () => watchDashboardUpdatesUsecase(any()),
        ).thenAnswer((_) => controller.stream);

        await cubit.loadDashboard();
        await cubit.close();

        expect(() => controller.add(Right(tDashboard)), returnsNormally);
        await controller.close();
      },
    );
  });
}
