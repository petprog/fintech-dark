import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class StatisticsCard extends StatelessWidget {
  final double totalSpending;
  final List<SpendingPointEntity> trend;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const StatisticsCard({
    super.key,
    required this.totalSpending,
    required this.trend,
    this.title = 'Total Spending',
    this.trailing,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(width: AppDimens.spaceS),
                    AnimatedAmount(
                      value: totalSpending,
                      style: AppTextStyles.headline,
                    ),
                  ],
                ),
                if (trailing != null) trailing!,
              ],
            ),

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
