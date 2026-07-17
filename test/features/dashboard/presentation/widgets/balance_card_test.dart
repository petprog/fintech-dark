import 'package:fintech_dark/core/core.dart';
import 'package:fintech_dark/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: AppTheme.dark,
      home: Scaffold(body: child),
    );
  }

  BalanceCard createCard({
    double balance = 1200,
    VoidCallback? onAddCash,
    VoidCallback? onSendMoney,
  }) {
    return BalanceCard(
      balance: balance,
      onAddCash: onAddCash ?? () {},
      onSendMoney: onSendMoney ?? () {},
    );
  }

  testWidgets('renders balance card labels and buttons', (tester) async {
    await tester.pumpWidget(wrap(createCard()));

    await tester.pumpAndSettle();

    expect(find.text(AppStrings.totalBalance), findsOneWidget);
    expect(find.text(AppStrings.addCash), findsOneWidget);
    expect(find.text(AppStrings.sendMoney), findsOneWidget);
  });

  testWidgets('renders balance amount', (tester) async {
    await tester.pumpWidget(wrap(createCard(balance: 1200)));

    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            (widget.data?.contains('1200') == true ||
                widget.data?.contains('1,200') == true),
      ),
      findsWidgets,
    );
  });

  testWidgets('updates balance when value changes', (tester) async {
    await tester.pumpWidget(wrap(createCard(balance: 1200)));

    await tester.pumpAndSettle();

    await tester.pumpWidget(wrap(createCard(balance: 5000)));

    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            (widget.data?.contains('5000') == true ||
                widget.data?.contains('5,000') == true),
      ),
      findsWidgets,
    );
  });

  testWidgets('renders zero balance', (tester) async {
    await tester.pumpWidget(wrap(createCard(balance: 0)));

    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('Add Cash button callback fires', (tester) async {
    var called = false;

    await tester.pumpWidget(wrap(createCard(onAddCash: () => called = true)));

    await tester.tap(find.text(AppStrings.addCash));
    await tester.pump();

    expect(called, true);
  });

  testWidgets('Send Money button callback fires', (tester) async {
    var called = false;

    await tester.pumpWidget(wrap(createCard(onSendMoney: () => called = true)));

    await tester.tap(find.text(AppStrings.sendMoney));
    await tester.pump();

    expect(called, true);
  });

  testWidgets('Add Cash does not trigger Send Money', (tester) async {
    var sendCalled = false;

    await tester.pumpWidget(
      wrap(createCard(onSendMoney: () => sendCalled = true)),
    );

    await tester.tap(find.text(AppStrings.addCash));
    await tester.pump();

    expect(sendCalled, false);
  });
}
