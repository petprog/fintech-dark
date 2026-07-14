import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'core/core.dart';
import 'features/features.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<DashboardCubit>(
          create: (_) => getIt<DashboardCubit>()..loadDashboard(),
        ),
        BlocProvider(create: (_) => getIt<CardSettingsCubit>()),
      ],
      child: const FintechDarkApp(),
    ),
  );
}

class FintechDarkApp extends StatelessWidget {
  const FintechDarkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Fintech Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
    );
  }
}
