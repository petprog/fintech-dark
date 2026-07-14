import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';

class DashboardErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const DashboardErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.spaceXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimens.spaceM),
              decoration: const BoxDecoration(
                color: Color(0x22FF5A5F),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                color: AppColors.error,
                size: 32,
              ),
            ),
            const SizedBox(height: AppDimens.spaceL),
            const Text('Something went wrong', style: AppTextStyles.title),
            const SizedBox(height: AppDimens.spaceXXS),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySecondary,
            ),
            const SizedBox(height: AppDimens.spaceL),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardEmptyView extends StatelessWidget {
  final String title;
  final String subtitle;

  const DashboardEmptyView({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spaceXL),
      child: Column(
        children: [
          const Icon(
            Icons.inbox_rounded,
            color: AppColors.textTertiary,
            size: 28,
          ),
          const SizedBox(height: AppDimens.spaceS),
          Text(title, style: AppTextStyles.body),
          const SizedBox(height: AppDimens.spaceXXS),
          Text(subtitle, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
