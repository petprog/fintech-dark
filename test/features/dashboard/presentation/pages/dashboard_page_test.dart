import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:fintech_dark/app/app.dart';
import 'package:fintech_dark/core/core.dart';
import 'package:fintech_dark/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
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

  final tDashboard = DashboardEntity(
    userName: 'Tayyab Sohail',
    email: 'tayyabsohailabd@gmail.com',
    totalBalance: 1200,
    totalSpending: 1200,
    spendingTrend: const [SpendingPointEntity(month: 'Jan', value: 900)],
    cards: const [],
    quickActions: const [
      QuickActionEntity(
        id: 'bill_pay',
        label: 'Bill Pay',
        iconName: 'bill_pay',
      ),
    ],
    transactions: [
      TransactionEntity(
        id: 'txn_1',
        title: 'E wallet',
        dateTime: DateTime(2024, 12, 12, 12, 10),
        amount: 100,
        isCredit: true,
        type: TransactionType.eWallet,
      ),
    ],
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
  });

  DashboardCubit buildCubit() => DashboardCubit(
    getDashboardUsecase: getDashboardUsecase,
    watchDashboardUpdatesUsecase: watchDashboardUpdatesUsecase,
    toggleFreezeCardUsecase: toggleFreezeCardUsecase,
  )..loadDashboard();

  Widget buildApp() {
    return MaterialApp(
      theme: AppTheme.dark,
      home: BlocProvider(
        create: (_) => buildCubit(),
        child: const DashboardPage(),
      ),
    );
  }

  Widget buildRouterApp() {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider(
            create: (_) => buildCubit(),
            child: const DashboardPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.activity,
          builder: (context, state) =>
              const Scaffold(body: Text('Activity Page')),
        ),
      ],
    );

    return MaterialApp.router(theme: AppTheme.dark, routerConfig: router);
  }

  Finder findRefreshableList() => find.byWidgetPredicate(
    (w) => w is ListView && w.physics is AlwaysScrollableScrollPhysics,
  );

  testWidgets('shows the shimmer while the dashboard is loading', (
    tester,
  ) async {
    final completer = Completer<Either<Failure, DashboardEntity>>();
    when(() => getDashboardUsecase()).thenAnswer((_) => completer.future);

    await tester.pumpWidget(buildApp());
    await tester.pump();

    expect(find.byType(DashboardShimmer), findsOneWidget);

    completer.complete(Right(tDashboard));
    await tester.pumpAndSettle();
  });

  testWidgets('shows dashboard content once loaded successfully', (
    tester,
  ) async {
    when(
      () => getDashboardUsecase(),
    ).thenAnswer((_) async => Right(tDashboard));

    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.text('E wallet'), findsWidgets);
    expect(find.byType(DashboardShimmer), findsNothing);
  });

  testWidgets(
    'shows DashboardErrorView with no lastKnownGood on first-load failure',
    (tester) async {
      when(
        () => getDashboardUsecase(),
      ).thenAnswer((_) async => const Left(ServerFailure('boom')));

      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      expect(find.byType(DashboardErrorView), findsOneWidget);
      expect(find.text('boom'), findsOneWidget);
      expect(find.text('Something went wrong'), findsOneWidget);
    },
  );

  testWidgets('retrying from the error view calls the usecase again', (
    tester,
  ) async {
    when(
      () => getDashboardUsecase(),
    ).thenAnswer((_) async => const Left(ServerFailure('boom')));

    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    when(
      () => getDashboardUsecase(),
    ).thenAnswer((_) async => Right(tDashboard));

    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();

    expect(find.byType(DashboardErrorView), findsNothing);
    expect(find.text('E wallet'), findsWidgets);
  });

  testWidgets('opening the drawer shows the AppDrawer with the userName', (
    tester,
  ) async {
    when(
      () => getDashboardUsecase(),
    ).thenAnswer((_) async => Right(tDashboard));

    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(AppDrawer), findsOneWidget);
    expect(find.text('Tayyab Sohail'), findsWidgets);
  });

  testWidgets('pulling to refresh calls the usecase again', (tester) async {
    when(
      () => getDashboardUsecase(),
    ).thenAnswer((_) async => Right(tDashboard));

    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.fling(findRefreshableList(), const Offset(0, 300), 1000);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    verify(() => getDashboardUsecase()).called(greaterThanOrEqualTo(2));
  });

  testWidgets('tapping "See all" navigates to the activity route', (
    tester,
  ) async {
    when(
      () => getDashboardUsecase(),
    ).thenAnswer((_) async => Right(tDashboard));

    await tester.pumpWidget(buildRouterApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('See all'));
    await tester.pumpAndSettle();

    expect(find.text('Activity Page'), findsOneWidget);
  });

  testWidgets(
    'a network failure on refresh keeps showing lastKnownGood content',
    (tester) async {
      when(
        () => getDashboardUsecase(),
      ).thenAnswer((_) async => Right(tDashboard));

      await tester.pumpWidget(buildApp());
      await tester.pumpAndSettle();

      when(
        () => getDashboardUsecase(),
      ).thenAnswer((_) async => const Left(NetworkFailure('offline')));

      await tester.fling(findRefreshableList(), const Offset(0, 300), 1000);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(find.text('E wallet'), findsWidgets);
      expect(find.byType(DashboardErrorView), findsNothing);
    },
  );
}
