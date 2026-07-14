import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class ActivityStatisticsCard extends StatelessWidget {
  final double totalSpending;
  final List<SpendingPointEntity> trend;
  final String title;
  final Widget? trailing;
  final Widget? filterRow;
  final VoidCallback? onTap;

  const ActivityStatisticsCard({
    super.key,
    required this.totalSpending,
    required this.trend,
    this.title = 'Total Spending',
    this.trailing,
    this.filterRow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimens.spaceL),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(AppDimens.radiusL),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontSize: 20),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: AppDimens.spaceXXS),
            AnimatedAmount(
              value: totalSpending,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontSize: 30),
            ),
            if (filterRow != null) ...[
              const SizedBox(height: AppDimens.spaceM),
              filterRow!,
            ],
            const SizedBox(height: AppDimens.spaceM),
            SizedBox(
              height: 140,
              child: trend.isEmpty
                  ? const SizedBox.shrink()
                  : SparklineChart(trend: trend),
            ),
          ],
        ),
      ),
    );
  }
}
