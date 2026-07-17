import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final AnimationController _pageController = AnimationController(
    vsync: this,
    duration: AppDurations.pageEntrance,
  )..forward();

  late final Animation<double> _pageFade = CurvedAnimation(
    parent: _pageController,
    curve: Curves.easeOut,
  );

  TransactionFilter _filter = TransactionFilter.weekly;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);
    final maxWidth = ResponsiveUtils.maxContentWidth(context);

    final userName = context.select<DashboardCubit, String>(
      (cubit) => switch (cubit.state) {
        DashboardLoaded(:final dashboard) => dashboard.userName,
        DashboardError(lastKnownGood: final d?) => d.userName,
        _ => '',
      },
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: AppDrawer(userName: userName),
      appBar: DashboardAppBar(
        userName: userName,
        onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
        onNotificationTap: () {},
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _pageFade,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: BlocBuilder<DashboardCubit, DashboardState>(
                builder: (context, state) {
                  return switch (state) {
                    DashboardInitial() ||
                    DashboardLoading() => const DashboardShimmer(),

                    DashboardError(:final message, :final lastKnownGood) =>
                      lastKnownGood == null
                          ? DashboardErrorView(
                              message: message,
                              onRetry: () => context
                                  .read<DashboardCubit>()
                                  .loadDashboard(),
                            )
                          : _DashboardContent(
                              dashboard: lastKnownGood,
                              isRefreshing: false,
                              horizontalPadding: horizontalPadding,
                              filter: _filter,
                              onFilterChanged: (f) =>
                                  setState(() => _filter = f),
                            ),

                    DashboardLoaded(:final dashboard, :final isRefreshing) =>
                      _DashboardContent(
                        dashboard: dashboard,
                        isRefreshing: isRefreshing,
                        horizontalPadding: horizontalPadding,
                        filter: _filter,
                        onFilterChanged: (f) => setState(() => _filter = f),
                      ),
                  };
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final DashboardEntity dashboard;
  final bool isRefreshing;
  final double horizontalPadding;
  final TransactionFilter filter;
  final ValueChanged<TransactionFilter> onFilterChanged;

  const _DashboardContent({
    required this.dashboard,
    required this.isRefreshing,
    required this.horizontalPadding,
    required this.filter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DashboardCubit>();

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surfaceElevated,
      onRefresh: cubit.refresh,
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: AppDimens.spaceM,
        ),
        children: [
          const SizedBox(height: AppDimens.spaceXL),

          StaggeredEntrance(
            child: BlocSelector<DashboardCubit, DashboardState, double>(
              selector: (state) => state is DashboardLoaded
                  ? state.dashboard.totalBalance / 100
                  : dashboard.totalBalance / 100,
              builder: (context, balance) => BalanceCard(
                balance: balance,
                onAddCash: () {},
                onSendMoney: () {},
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceXXL),

          StaggeredEntrance(
            delay: AppDurations.cardStagger,
            child: QuickActionsSection(
              actions: dashboard.quickActions,
              onActionTap: (_) {},
            ),
          ),
          const SizedBox(height: AppDimens.spaceXXL),

          StaggeredEntrance(
            delay: AppDurations.cardStagger * 4,
            child: TransactionHistorySection(
              transactions: dashboard.transactions,
              selectedFilter: filter,
              onFilterChanged: onFilterChanged,
              onSeeAll: () => context.push(AppRoutes.activity),
            ),
          ),
          const SizedBox(height: AppDimens.spaceXXL),
        ],
      ),
    );
  }
}
