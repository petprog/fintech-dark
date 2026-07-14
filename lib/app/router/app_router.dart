import 'package:go_router/go_router.dart';
import '../../features/features.dart';
import '../app.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const DashboardPage()),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: AppRoutes.activity,
      builder: (context, state) => const ActivityPage(),
    ),
    GoRoute(
      path: AppRoutes.cardTransaction,
      builder: (context, state) => const CardTransactionPage(),
    ),
    GoRoute(
      path: AppRoutes.card,
      builder: (context, state) => const CardPage(),
    ),
  ],
);
