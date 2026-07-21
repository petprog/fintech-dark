import 'package:fintech_dark/common/widgets/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/features.dart';
part 'app_router.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: const DashboardRoute().location,
  routes: $appRoutes,
);

@TypedShellRoute<AppShellRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<DashboardRoute>(
      path: '/',
      name: 'dashboard',
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ProfileRoute>(
          path: 'profile',
          name: 'profile',
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<EStatementRoute>(
              path: 'e-statement',
              name: 'eStatement',
            ),
            TypedGoRoute<SettingsRoute>(path: 'settings', name: 'settings'),
            TypedGoRoute<LanguageRoute>(path: 'language', name: 'language'),
            TypedGoRoute<CountryRoute>(path: 'country', name: 'country'),
          ],
        ),

        TypedGoRoute<CardsRoute>(
          path: 'cards',
          name: 'cards',
          routes: <TypedRoute<RouteData>>[
            TypedGoRoute<CardTransactionRoute>(
              path: 'transaction',
              name: 'cardTransaction',
              routes: <TypedRoute<RouteData>>[
                TypedGoRoute<ActivityRoute>(path: 'activity', name: 'activity'),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
)
class AppShellRoute extends ShellRouteData {
  const AppShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return AppShell(child: navigator);
  }
}

class DashboardRoute extends GoRouteData with $DashboardRoute {
  const DashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DashboardPage();
  }
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfilePage();
  }
}

class EStatementRoute extends GoRouteData with $EStatementRoute {
  const EStatementRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EStatementPage();
  }
}

class CardsRoute extends GoRouteData with $CardsRoute {
  const CardsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CardPage();
  }
}

class CardTransactionRoute extends GoRouteData with $CardTransactionRoute {
  const CardTransactionRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CardTransactionPage();
  }
}

class ActivityRoute extends GoRouteData with $ActivityRoute {
  const ActivityRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ActivityPage();
  }
}

class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

class LanguageRoute extends GoRouteData with $LanguageRoute {
  const LanguageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LanguagePage();
  }
}

class CountryRoute extends GoRouteData with $CountryRoute {
  const CountryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CountryPage();
  }
}
