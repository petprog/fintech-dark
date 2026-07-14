import 'package:fintech_dark/core/core.dart';
import 'package:fintech_dark/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tActions = [
    QuickActionEntity(id: 'bill_pay', label: 'Bill Pay', iconName: 'bill_pay'),
    QuickActionEntity(id: 'deposit', label: 'Deposit', iconName: 'deposit'),
  ];

  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.dark,
    home: Scaffold(body: child),
  );

  testWidgets('renders the label for every quick action', (tester) async {
    await tester.pumpWidget(
      wrap(QuickActionsSection(actions: tActions, onActionTap: (_) {})),
    );

    expect(find.text('Bill Pay'), findsOneWidget);
    expect(find.text('Deposit'), findsOneWidget);
  });

  testWidgets('renders an empty action list without throwing', (tester) async {
    await tester.pumpWidget(
      wrap(QuickActionsSection(actions: const [], onActionTap: (_) {})),
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets('tapping a quick action reports its id', (tester) async {
    QuickActionEntity? tappedAction;

    await tester.pumpWidget(
      wrap(
        QuickActionsSection(
          actions: tActions,
          onActionTap: (action) => tappedAction = action,
        ),
      ),
    );

    await tester.tap(find.text('Deposit'));
    await tester.pump();

    expect(tappedAction, isNotNull);
    expect(tappedAction!.id, 'deposit');
    expect(tappedAction!.label, 'Deposit');
  });

  testWidgets('tapping one action does not report a different action\'s id', (
    tester,
  ) async {
    QuickActionEntity? tappedAction;

    await tester.pumpWidget(
      wrap(
        QuickActionsSection(
          actions: tActions,
          onActionTap: (action) => tappedAction = action,
        ),
      ),
    );

    await tester.tap(find.text('Bill Pay'));
    await tester.pump();

    expect(tappedAction, isNotNull);
    expect(tappedAction!.id, 'bill_pay');
    expect(tappedAction!.id, isNot('deposit'));
  });

  testWidgets('renders a single action correctly', (tester) async {
    await tester.pumpWidget(
      wrap(QuickActionsSection(actions: [tActions.first], onActionTap: (_) {})),
    );

    expect(find.text('Bill Pay'), findsOneWidget);
    expect(find.text('Deposit'), findsNothing);
  });
}
