import 'package:fintech_dark/app/app.dart';
import 'package:fintech_dark/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/features.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (ResponsiveUtils.isDesktop(context) ||
        ResponsiveUtils.isTablet(context)) {
      return _DesktopShell(child: child);
    }

    return _MobileShell(child: child);
  }
}

class _MobileShell extends StatefulWidget {
  const _MobileShell({required this.child});

  final Widget child;

  @override
  State<_MobileShell> createState() => _MobileShellState();
}

class _MobileShellState extends State<_MobileShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final showDrawer = location == const DashboardRoute().location;
    return Scaffold(
      key: _scaffoldKey,
      appBar: showDrawer
          ? DashboardAppBar(
              onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
              onNotificationTap: () {},
            )
          : null,
      drawer: showDrawer ? const AppDrawer() : null,
      body: widget.child,
    );
  }
}

class _DesktopShell extends StatelessWidget {
  const _DesktopShell({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const AppDrawer(isPermanent: true),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}
