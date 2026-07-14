import 'package:flutter/material.dart';
import '../../../../common/common.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

const Map<String, String> _quickActionIcons = {
  'bill_pay': AppAssets.billPay,
  'donations': AppAssets.donations,
  'deposit': AppAssets.deposit,
  'more': AppAssets.moreGrid,
};

class QuickActionItem extends StatelessWidget {
  final QuickActionEntity action;
  final VoidCallback onTap;

  const QuickActionItem({super.key, required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimens.spaceM,
            horizontal: AppDimens.spaceS,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularSvgIcon(
                assetName:
                    _quickActionIcons[action.iconName] ?? AppAssets.billPay,
                iconColor: AppColors.textPrimary,
                size: 42,
                iconSize: 20,
              ),
              const SizedBox(height: AppDimens.spaceXS),
              Text(
                action.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: 12,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickActionsSection extends StatelessWidget {
  final List<QuickActionEntity> actions;
  final void Function(QuickActionEntity) onActionTap;

  const QuickActionsSection({
    super.key,
    required this.actions,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (int i = 0; i < actions.length; i++) ...[
              Expanded(
                child: QuickActionItem(
                  key: ValueKey(actions[i].id),
                  action: actions[i],
                  onTap: () => onActionTap(actions[i]),
                ),
              ),
              if (i != actions.length - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppDimens.spaceM),
                  child: VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: AppColors.divider,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
