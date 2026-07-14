import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  StatsPeriod _period = StatsPeriod.weekly;
  TransactionFilter _txnFilter = TransactionFilter.weekly;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: horizontalPadding,
        title: Text(
          AppStrings.myActivity,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded),
          ),
          SizedBox(width: horizontalPadding),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimens.spaceXS),

            Expanded(
              child: BlocBuilder<DashboardCubit, DashboardState>(
                builder: (context, state) {
                  final dashboard = switch (state) {
                    DashboardLoaded(:final dashboard) => dashboard,
                    DashboardError(lastKnownGood: final d?) => d,
                    _ => null,
                  };

                  if (dashboard == null) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  return ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                        ),
                        child: StaggeredEntrance(
                          child: ActivityStatisticsCard(
                            title: 'Total Spending',
                            totalSpending: dashboard.totalSpending,
                            trend: dashboard.spendingTrend,
                            filterRow: PeriodFilterRow(
                              selected: _period,
                              onChanged: (p) => setState(() => _period = p),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimens.spaceXL),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                        ),
                        child: StaggeredEntrance(
                          delay: AppDurations.cardStagger,
                          child: RecentTransferRow(
                            initials: _initialsFor(dashboard),
                            onAddTap: () {},
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimens.spaceL),
                      const Divider(height: 0),
                      const SizedBox(height: AppDimens.spaceM),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                        ),
                        child: StaggeredEntrance(
                          delay: AppDurations.cardStagger * 2,
                          child: TransactionHistorySection(
                            transactions: dashboard.transactions,
                            selectedFilter: _txnFilter,
                            onFilterChanged: (f) =>
                                setState(() => _txnFilter = f),
                            onSeeAll: () {},
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimens.spaceXXL),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _initialsFor(DashboardEntity dashboard) {
    final titles = dashboard.transactions.map((t) => t.title).toSet().take(3);
    return titles
        .map((t) => t.trim().isEmpty ? '?' : t.trim()[0].toUpperCase())
        .toList();
  }
}
