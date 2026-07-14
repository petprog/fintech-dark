import 'package:fintech_dark/core/core.dart';
import 'package:fintech_dark/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTransactions = [
    TransactionEntity(
      id: 'txn_1',
      title: 'E wallet',
      dateTime: DateTime(2024, 12, 12, 12, 10),
      amount: 100,
      isCredit: true,
      type: TransactionType.eWallet,
    ),
    TransactionEntity(
      id: 'txn_2',
      title: 'Netflix',
      dateTime: DateTime(2024, 12, 11, 9, 0),
      amount: 50,
      isCredit: false,
      type: TransactionType.onlineShopping,
    ),
  ];

  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.dark,
    home: Scaffold(body: child),
  );

  testWidgets('renders the section title and "See all"', (tester) async {
    await tester.pumpWidget(
      wrap(
        TransactionHistorySection(
          transactions: tTransactions,
          selectedFilter: TransactionFilter.weekly,
          onFilterChanged: (_) {},
          onSeeAll: () {},
        ),
      ),
    );

    expect(find.text(AppStrings.transactionHistory), findsOneWidget);
    expect(find.text(AppStrings.seeAll), findsOneWidget);
  });

  testWidgets('renders one TransactionListItem per transaction, keyed by id', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        TransactionHistorySection(
          transactions: tTransactions,
          selectedFilter: TransactionFilter.weekly,
          onFilterChanged: (_) {},
          onSeeAll: () {},
        ),
      ),
    );

    expect(find.byType(TransactionListItem), findsNWidgets(2));
    expect(find.byKey(const ValueKey('txn_1')), findsOneWidget);
    expect(find.byKey(const ValueKey('txn_2')), findsOneWidget);
  });

  testWidgets('renders each transaction title and formatted date', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        TransactionHistorySection(
          transactions: tTransactions,
          selectedFilter: TransactionFilter.weekly,
          onFilterChanged: (_) {},
          onSeeAll: () {},
        ),
      ),
    );

    expect(find.text('E wallet'), findsOneWidget);
    expect(find.text('Netflix'), findsOneWidget);
    expect(
      find.text(Formatters.date(tTransactions[0].dateTime)),
      findsOneWidget,
    );
    expect(
      find.text(Formatters.date(tTransactions[1].dateTime)),
      findsOneWidget,
    );
  });

  testWidgets(
    'renders the exact signed amount text via Formatters.signedAmount2',
    (tester) async {
      await tester.pumpWidget(
        wrap(
          TransactionHistorySection(
            transactions: tTransactions,
            selectedFilter: TransactionFilter.weekly,
            onFilterChanged: (_) {},
            onSeeAll: () {},
          ),
        ),
      );

      expect(find.text(Formatters.signedAmount2(100)), findsOneWidget);
      expect(find.text(Formatters.signedAmount2(-50)), findsOneWidget);
    },
  );

  testWidgets(
    'renders a separator between rows (n-1 dividers for n transactions)',
    (tester) async {
      await tester.pumpWidget(
        wrap(
          TransactionHistorySection(
            transactions: tTransactions,
            selectedFilter: TransactionFilter.weekly,
            onFilterChanged: (_) {},
            onSeeAll: () {},
          ),
        ),
      );

      expect(find.byType(Divider), findsOneWidget);
    },
  );

  testWidgets(
    'shows DashboardEmptyView instead of a list when transactions is empty',
    (tester) async {
      await tester.pumpWidget(
        wrap(
          TransactionHistorySection(
            transactions: const [],
            selectedFilter: TransactionFilter.weekly,
            onFilterChanged: (_) {},
            onSeeAll: () {},
          ),
        ),
      );

      expect(find.byType(DashboardEmptyView), findsOneWidget);
      expect(find.text('No transactions yet'), findsOneWidget);
      expect(find.text('Your activity will show up here.'), findsOneWidget);
      expect(find.byType(TransactionListItem), findsNothing);
      expect(find.byType(ListView), findsNothing);
    },
  );

  testWidgets('renders all three filter chips: Weekly, Monthly, Today', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        TransactionHistorySection(
          transactions: tTransactions,
          selectedFilter: TransactionFilter.weekly,
          onFilterChanged: (_) {},
          onSeeAll: () {},
        ),
      ),
    );

    expect(find.widgetWithText(ChoiceChip, 'Weekly'), findsOneWidget);
    expect(find.widgetWithText(ChoiceChip, 'Monthly'), findsOneWidget);
    expect(find.widgetWithText(ChoiceChip, 'Today'), findsOneWidget);
  });

  testWidgets(
    'the selectedFilter chip has selected:true and the others false',
    (tester) async {
      await tester.pumpWidget(
        wrap(
          TransactionHistorySection(
            transactions: tTransactions,
            selectedFilter: TransactionFilter.monthly,
            onFilterChanged: (_) {},
            onSeeAll: () {},
          ),
        ),
      );

      final weeklyChip = tester.widget<ChoiceChip>(
        find.widgetWithText(ChoiceChip, 'Weekly'),
      );
      final monthlyChip = tester.widget<ChoiceChip>(
        find.widgetWithText(ChoiceChip, 'Monthly'),
      );
      final todayChip = tester.widget<ChoiceChip>(
        find.widgetWithText(ChoiceChip, 'Today'),
      );

      expect(weeklyChip.selected, false);
      expect(monthlyChip.selected, true);
      expect(todayChip.selected, false);
    },
  );

  testWidgets('tapping "Monthly" reports TransactionFilter.monthly', (
    tester,
  ) async {
    TransactionFilter? tapped;

    await tester.pumpWidget(
      wrap(
        TransactionHistorySection(
          transactions: tTransactions,
          selectedFilter: TransactionFilter.weekly,
          onFilterChanged: (f) => tapped = f,
          onSeeAll: () {},
        ),
      ),
    );

    await tester.tap(find.text('Monthly'));
    await tester.pump();

    expect(tapped, TransactionFilter.monthly);
  });

  testWidgets('tapping "Today" reports TransactionFilter.today', (
    tester,
  ) async {
    TransactionFilter? tapped;

    await tester.pumpWidget(
      wrap(
        TransactionHistorySection(
          transactions: tTransactions,
          selectedFilter: TransactionFilter.weekly,
          onFilterChanged: (f) => tapped = f,
          onSeeAll: () {},
        ),
      ),
    );

    await tester.tap(find.text('Today'));
    await tester.pump();

    expect(tapped, TransactionFilter.today);
  });

  testWidgets('tapping "Weekly" while Monthly is selected reports weekly', (
    tester,
  ) async {
    TransactionFilter? tapped;

    await tester.pumpWidget(
      wrap(
        TransactionHistorySection(
          transactions: tTransactions,
          selectedFilter: TransactionFilter.monthly,
          onFilterChanged: (f) => tapped = f,
          onSeeAll: () {},
        ),
      ),
    );

    await tester.tap(find.text('Weekly'));
    await tester.pump();

    expect(tapped, TransactionFilter.weekly);
  });

  testWidgets(
    'tapping the already-selected chip still reports it (idempotent tap)',
    (tester) async {
      TransactionFilter? tapped;

      await tester.pumpWidget(
        wrap(
          TransactionHistorySection(
            transactions: tTransactions,
            selectedFilter: TransactionFilter.weekly,
            onFilterChanged: (f) => tapped = f,
            onSeeAll: () {},
          ),
        ),
      );

      await tester.tap(find.text('Weekly'));
      await tester.pump();

      expect(tapped, TransactionFilter.weekly);
    },
  );

  testWidgets('tapping "See all" invokes onSeeAll exactly once', (
    tester,
  ) async {
    var count = 0;

    await tester.pumpWidget(
      wrap(
        TransactionHistorySection(
          transactions: tTransactions,
          selectedFilter: TransactionFilter.weekly,
          onFilterChanged: (_) {},
          onSeeAll: () => count++,
        ),
      ),
    );

    await tester.tap(find.text(AppStrings.seeAll));
    await tester.pump();

    expect(count, 1);
  });

  testWidgets(
    'an unrecognized TransactionType falls back to the default icon without throwing',
    (tester) async {
      await tester.pumpWidget(
        wrap(
          TransactionHistorySection(
            transactions: [
              TransactionEntity(
                id: 'txn_x',
                title: 'Mystery charge',
                dateTime: DateTime(2024, 1, 1),
                amount: 10,
                isCredit: false,
                type: TransactionType.transfer,
              ),
            ],
            selectedFilter: TransactionFilter.weekly,
            onFilterChanged: (_) {},
            onSeeAll: () {},
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.text('Mystery charge'), findsOneWidget);
    },
  );

  testWidgets('renders many transactions without throwing (shrinkWrap-safe)', (
    tester,
  ) async {
    final many = List.generate(
      30,
      (i) => TransactionEntity(
        id: 'txn_$i',
        title: 'Txn $i',
        dateTime: DateTime(2024, 1, i % 28 + 1),
        amount: (i + 1).toDouble(),
        isCredit: i.isEven,
        type: TransactionType.eWallet,
      ),
    );

    await tester.pumpWidget(
      wrap(
        SingleChildScrollView(
          child: TransactionHistorySection(
            transactions: many,
            selectedFilter: TransactionFilter.weekly,
            onFilterChanged: (_) {},
            onSeeAll: () {},
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.byType(TransactionListItem), findsNWidgets(30));
  });
}
