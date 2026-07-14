import 'package:flutter/material.dart';

import '../../../../common/common.dart';
import '../../../../core/core.dart';

class ProfileListTile extends StatelessWidget {
  final String iconName;
  final String label;
  final VoidCallback onTap;

  const ProfileListTile({
    super.key,
    required this.iconName,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      tileColor: AppColors.surfaceElevated,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      splashColor: AppColors.primary.withValues(alpha: 0.1),
      leading: CircularSvgIcon(
        iconSize: 24,
        assetName: iconName,
        iconColor: AppColors.primary,
        size: 40,
      ),

      title: Text(
        label,
        style: AppTextStyles.body.copyWith(
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
      ),

      trailing: const AppSvg(assetName: AppAssets.chevronRight),

      onTap: onTap,
    );
  }
}

class ProfileSwitchTile extends StatelessWidget {
  final String iconName;
  final String label;
  final bool switchValue;
  final Function(bool)? onSwitchChanged;

  const ProfileSwitchTile({
    super.key,
    required this.iconName,
    required this.label,
    required this.switchValue,
    required this.onSwitchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      tileColor: AppColors.surfaceElevated,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      splashColor: AppColors.primary.withValues(alpha: 0.1),
      leading: CircularSvgIcon(
        iconSize: 24,
        assetName: iconName,
        iconColor: AppColors.primary,
        size: 40,
      ),
      title: Text(
        label,
        style: AppTextStyles.body.copyWith(
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
      ),

      trailing: Switch(value: switchValue, onChanged: onSwitchChanged),
    );
  }
}
