import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/core.dart';
import '../features/features.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardCubit>(
          create: (_) => getIt<DashboardCubit>()..loadDashboard(),
        ),

        BlocProvider<CardSettingsCubit>(
          create: (_) => getIt<CardSettingsCubit>(),
        ),
      ],
      child: child,
    );
  }
}
