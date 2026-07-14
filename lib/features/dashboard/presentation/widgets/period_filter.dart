import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';

enum StatsPeriod { weekly, monthly, today, year }

String periodLabel(StatsPeriod period) {
  switch (period) {
    case StatsPeriod.weekly:
      return 'Weekly';
    case StatsPeriod.monthly:
      return 'Monthly';
    case StatsPeriod.today:
      return 'Today';
    case StatsPeriod.year:
      return 'Year';
  }
}

class PeriodFilterRow extends StatelessWidget {
  final StatsPeriod selected;
  final ValueChanged<StatsPeriod> onChanged;
  final List<StatsPeriod> periods;

  const PeriodFilterRow({
    super.key,
    required this.selected,
    required this.onChanged,
    this.periods = StatsPeriod.values,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        itemCount: periods.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppDimens.spaceXS),
        itemBuilder: (context, index) {
          final period = periods[index];
          final isSelected = period == selected;

          return ChoiceChip(
            label: Text(periodLabel(period)),
            selected: isSelected,
            onSelected: (_) => onChanged(period),
            showCheckmark: false,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            labelPadding: const EdgeInsets.symmetric(
              horizontal: AppDimens.spaceS,
            ),
            labelStyle: AppTextStyles.caption.copyWith(
              color: isSelected
                  ? AppColors.textOnPrimary
                  : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
            selectedColor: AppColors.surfaceCard,
            backgroundColor: AppColors.surfaceElevated,
            side: BorderSide(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 1.2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.radiusPill),
            ),
          );
        },
      ),
    );
  }
}

class PeriodDropdownPill extends StatelessWidget {
  final StatsPeriod selected;
  final ValueChanged<StatsPeriod> onChanged;

  const PeriodDropdownPill({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<StatsPeriod>(
      onSelected: onChanged,
      color: AppColors.surfaceElevated,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
      ),
      itemBuilder: (context) => StatsPeriod.values
          .map((p) => PopupMenuItem(value: p, child: Text(periodLabel(p))))
          .toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spaceS,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(AppDimens.radiusPill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: AppColors.textSecondary,
            ),
            Text(
              periodLabel(selected),
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
