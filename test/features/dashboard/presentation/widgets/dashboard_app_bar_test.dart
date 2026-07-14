import 'package:fintech_dark/core/core.dart';
import 'package:fintech_dark/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(
    theme: AppTheme.dark,
    home: Scaffold(appBar: child as PreferredSizeWidget),
  );

  testWidgets('renders the given userName', (tester) async {
    await tester.pumpWidget(
      wrap(
        DashboardAppBar(
          userName: 'Tayyab Sohail',
          isRefreshing: false,
          onMenuTap: () {},
          onNotificationTap: () {},
        ),
      ),
    );

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
    await tester.pumpWidget(
      wrap(
        DashboardAppBar(
          userName: '',
          isRefreshing: false,
          onMenuTap: () {},
          onNotificationTap: () {},
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets('tapping the menu control invokes onMenuTap', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      wrap(
        DashboardAppBar(
          userName: 'Tayyab',
          isRefreshing: false,
          onMenuTap: () => tapped = true,
          onNotificationTap: () {},
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.menu_rounded));
    await tester.pump();

    expect(tapped, isTrue);
  });

  testWidgets('tapping the notification control invokes onNotificationTap', (
    tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      wrap(
        DashboardAppBar(
          userName: 'Tayyab',
          isRefreshing: false,
          onMenuTap: () {},
          onNotificationTap: () => tapped = true,
        ),
      ),
    );

    await tester.tap(find.byType(GestureDetector).last);
    await tester.pump();

    expect(tapped, isTrue);
  });
}
