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

  DashboardCubit buildCubit() {
    return DashboardCubit(
      getDashboardUsecase: getDashboardUsecase,
      watchDashboardUpdatesUsecase: watchDashboardUpdatesUsecase,
      toggleFreezeCardUsecase: toggleFreezeCardUsecase,
    );
  }

  Widget wrap(Widget child, DashboardCubit cubit) {
    return MaterialApp(
      theme: AppTheme.dark,
      home: BlocProvider.value(
        value: cubit,
        child: Scaffold(appBar: child as PreferredSizeWidget),
      ),
    );
  }

  testWidgets('renders the given userName', (tester) async {
    when(
      () => getDashboardUsecase(),
    ).thenAnswer((_) async => Right(tDashboard));

    final cubit = buildCubit();
    addTearDown(cubit.close);

    await cubit.loadDashboard();

    await tester.pumpWidget(
      wrap(DashboardAppBar(onMenuTap: () {}, onNotificationTap: () {}), cubit),
    );

    await tester.pump();

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText().contains('Tayyab Sohail'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('renders gracefully with an empty userName', (tester) async {
    final cubit = buildCubit();
    addTearDown(cubit.close);

    await tester.pumpWidget(
      wrap(DashboardAppBar(onMenuTap: () {}, onNotificationTap: () {}), cubit),
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets('tapping the menu control invokes onMenuTap', (tester) async {
    final cubit = buildCubit();
    addTearDown(cubit.close);

    var tapped = false;

    await tester.pumpWidget(
      wrap(
        DashboardAppBar(
          onMenuTap: () => tapped = true,
          onNotificationTap: () {},
        ),
        cubit,
      ),
    );

    await tester.tap(find.byIcon(Icons.menu_rounded));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('tapping the notification control invokes onNotificationTap', (
    tester,
  ) async {
    final cubit = buildCubit();
    addTearDown(cubit.close);

    var tapped = false;

    await tester.pumpWidget(
      wrap(
        DashboardAppBar(
          onMenuTap: () {},
          onNotificationTap: () => tapped = true,
        ),
        cubit,
      ),
    );

    final gestureDetectorFinder = find.byType(GestureDetector);

    expect(gestureDetectorFinder, findsWidgets);

    await tester.tap(gestureDetectorFinder.last);
    await tester.pump();

    expect(tapped, isTrue);
  });
}
