import 'package:flutter/material.dart';
import 'app/app.dart';
import 'core/core.dart';

Future<void> main() async {
  await AppBootstrap.initialize();
  runApp(const FintechDarkApp());
}

class FintechDarkApp extends StatelessWidget {
  const FintechDarkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocProviders(
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'Fintech Dashboard',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
      ),
    );
  }
}
