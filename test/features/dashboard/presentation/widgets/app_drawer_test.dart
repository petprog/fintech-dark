import 'package:fintech_dark/core/core.dart';
import 'package:fintech_dark/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the given userName when opened', (tester) async {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          key: scaffoldKey,
          drawer: const AppDrawer(userName: 'Tayyab Sohail'),
          body: const SizedBox(),
        ),
      ),
    );

    scaffoldKey.currentState?.openDrawer();
    await tester.pumpAndSettle();

    expect(find.textContaining('Tayyab Sohail'), findsOneWidget);
  });

  testWidgets('renders without throwing for an empty userName', (tester) async {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          key: scaffoldKey,
          drawer: const AppDrawer(userName: ''),
          body: const SizedBox(),
        ),
      ),
    );

    scaffoldKey.currentState?.openDrawer();
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
