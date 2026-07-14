import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class SparklineChart extends StatelessWidget {
  final List<SpendingPointEntity> trend;

  const SparklineChart({super.key, required this.trend});

  @override
  Widget build(BuildContext context) {
    final spots = [
      for (var i = 0; i < trend.length; i++)
        FlSpot(i.toDouble(), trend[i].value),
    ];
    final maxY = trend.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: maxY * 1.2,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= trend.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(trend[index].month, style: AppTextStyles.caption),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => AppColors.surfaceElevated,
            getTooltipItems: (touchedSpots) => touchedSpots
                .map(
                  (s) => LineTooltipItem(
                    '\$${s.y.toStringAsFixed(0)}',
                    AppTextStyles.caption.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: AppColors.chartLine,
            barWidth: 2.5,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.chartFillGradient,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
