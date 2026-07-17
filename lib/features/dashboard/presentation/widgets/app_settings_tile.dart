import 'package:flutter/material.dart';

import '../../../../common/common.dart';
import '../../../../core/core.dart';

class AppActionTile extends StatelessWidget {
  final String iconName;
  final String label;
  final Widget trailing;
  final VoidCallback? onTap;

  final Widget leading;
  final TextStyle? titleStyle;

  const AppActionTile({
    super.key,
    required this.iconName,
    required this.label,
    required this.trailing,
    this.onTap,
    this.leading = const SizedBox(),
    this.titleStyle,
  });

  factory AppActionTile.arrow({
    Key? key,
    required String iconName,
    required String label,
    required VoidCallback onTap,
    bool circularIcon = true,
  }) {
    return AppActionTile(
      key: key,
      iconName: iconName,
      label: label,
      leading: circularIcon
          ? CircularSvgIcon(
              iconSize: 24,
              assetName: iconName,
              iconColor: AppColors.primary,
              size: 40,
            )
          : AppSvg(assetName: iconName, color: AppColors.textPrimary, size: 28),
      trailing: const AppSvg(assetName: AppAssets.chevronRight),
      onTap: onTap,
    );
  }

  factory AppActionTile.switchTile({
    Key? key,
    required String iconName,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool circularIcon = true,
  }) {
    return AppActionTile(
      key: key,
      iconName: iconName,
      label: label,
      leading: circularIcon
          ? CircularSvgIcon(
              iconSize: 24,
              assetName: iconName,
              iconColor: AppColors.primary,
              size: 40,
            )
          : AppSvg(assetName: iconName, color: AppColors.textPrimary, size: 20),
      trailing: Switch(value: value, onChanged: onChanged),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppDimens.spaceM),
      tileColor: AppColors.surfaceElevated,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      splashColor: AppColors.primary.withValues(alpha: 0.1),

      leading: leading,

      title: Text(
        label,
        style:
            titleStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
      ),

      trailing: trailing,
      onTap: onTap,
    );
  }
}
