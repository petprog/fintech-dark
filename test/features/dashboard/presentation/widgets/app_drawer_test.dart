import 'package:dartz/dartz.dart';
import 'package:fintech_dark/core/core.dart';
import 'package:fintech_dark/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final tDashboard = DashboardEntity(
    userName: 'Tayyab Sohail',
    email: 'tayyabsohailabd@gmail.com',
    totalBalance: 1200,
    totalSpending: 1200,
    spendingTrend: const [],
    cards: const [],
    quickActions: const [],
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
  });

  DashboardCubit buildCubit() => DashboardCubit(
    getDashboardUsecase: getDashboardUsecase,
    watchDashboardUpdatesUsecase: watchDashboardUpdatesUsecase,
    toggleFreezeCardUsecase: toggleFreezeCardUsecase,
  );

  testWidgets('renders the given userName when opened', (tester) async {
    when(
      () => getDashboardUsecase(),
    ).thenAnswer((_) async => Right(tDashboard));

    final cubit = buildCubit()..loadDashboard();
    addTearDown(cubit.close);

    final scaffoldKey = GlobalKey<ScaffoldState>();

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: BlocProvider.value(
          value: cubit,
          child: Scaffold(
            key: scaffoldKey,
            drawer: const AppDrawer(),
            body: const SizedBox(),
          ),
        ),
      ),
    );

    scaffoldKey.currentState?.openDrawer();
    await tester.pumpAndSettle();

    expect(find.textContaining('Tayyab Sohail'), findsOneWidget);
  });

  testWidgets('renders without throwing for an empty userName', (tester) async {
    final cubit = buildCubit();
    addTearDown(cubit.close);

    final scaffoldKey = GlobalKey<ScaffoldState>();

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: BlocProvider.value(
          value: cubit,
          child: Scaffold(
            key: scaffoldKey,
            drawer: const AppDrawer(),
            body: const SizedBox(),
          ),
        ),
      ),
    );

    scaffoldKey.currentState?.openDrawer();
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
