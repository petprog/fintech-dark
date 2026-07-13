import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const FintechDarkApp());
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
