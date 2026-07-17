import 'package:fintech_dark/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class CardTransactionPage extends StatefulWidget {
  const CardTransactionPage({super.key});

  @override
  State<CardTransactionPage> createState() => _CardTransactionPageState();
}

class _CardTransactionPageState extends State<CardTransactionPage> {
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
          AppStrings.cardTransaction,
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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

                    final card = dashboard.cards.isNotEmpty
                        ? dashboard.cards.first
                        : null;

                    return ListView(
                      children: [
                        if (card != null)
                          StaggeredEntrance(
                            child: SizedBox(
                              height: 170,
                              width: MediaQuery.of(context).size.width * .8,
                              child: BankCard(card: card),
                            ),
                          ),
                        const SizedBox(height: AppDimens.spaceL),
                        StaggeredEntrance(
                          delay: AppDurations.cardStagger,
                          child: GestureDetector(
                            child: StatisticsCard(
                              title: AppStrings.totalSpend,
                              totalSpending: dashboard.totalSpending / 100,
                              trend: dashboard.spendingTrend,
                              trailing: PeriodDropdownPill(
                                selected: _period,
                                onChanged: (p) => setState(() => _period = p),
                              ),
                              onTap: () => context.push(AppRoutes.activity),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDimens.spaceXL),
                        StaggeredEntrance(
                          delay: AppDurations.cardStagger * 2,
                          child: TransactionHistorySection(
                            transactions: dashboard.transactions,
                            selectedFilter: _txnFilter,
                            onFilterChanged: (f) =>
                                setState(() => _txnFilter = f),
                            onSeeAll: () {},
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
      ),
    );
  }
}
