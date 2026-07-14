import 'package:flutter/material.dart';
import '../../../../common/common.dart';
import '../../../../core/core.dart';

class SettingsListTile extends StatelessWidget {
  final String iconName;
  final String label;
  final VoidCallback onTap;

  const SettingsListTile({
    super.key,
    required this.iconName,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppDimens.spaceM),
      tileColor: AppColors.surfaceElevated,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      splashColor: AppColors.primary.withValues(alpha: 0.1),
      leading: AppSvg(
        assetName: iconName,
        color: AppColors.textPrimary,
        size: 28,
      ),
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 20,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: const AppSvg(assetName: AppAssets.chevronRight),
      onTap: onTap,
    );
  }
}

class SettingsSwitchTile extends StatelessWidget {
  final String iconName;
  final String label;
  final bool switchValue;
  final Function(bool)? onSwitchChanged;

  const SettingsSwitchTile({
    super.key,
    required this.iconName,
    required this.label,
    required this.switchValue,
    required this.onSwitchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppDimens.spaceM),
      tileColor: AppColors.surfaceElevated,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      splashColor: AppColors.primary.withValues(alpha: 0.1),
      leading: AppSvg(
        assetName: iconName,
        color: AppColors.textPrimary,
        size: 20,
      ),
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 20,
          color: AppColors.textPrimary,
        ),
      ),

      trailing: Switch(value: switchValue, onChanged: onSwitchChanged),
    );
  }
}

class SettingsSectionLabel extends StatelessWidget {
  final String label;

  const SettingsSectionLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.spaceXS),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontSize: 20, height: 1.4),
      ),
    );
  }
}
