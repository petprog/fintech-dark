import 'package:flutter/material.dart';
import '../../../../common/common.dart';
import '../../../../core/core.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final VoidCallback onMenuTap;
  final VoidCallback onNotificationTap;

  const DashboardAppBar({
    super.key,
    required this.userName,
    required this.onMenuTap,
    required this.onNotificationTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF272729),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 56,
      leading: IconButton(
        icon: const Icon(Icons.menu_rounded),
        onPressed: onMenuTap,
      ),
      titleSpacing: 0,
      centerTitle: true,
      title: RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: AppTextStyles.body.copyWith(color: Colors.white),
          children: [
            const TextSpan(text: 'Welcome '),
            TextSpan(text: userName, style: AppTextStyles.title),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppDimens.spaceM),
          child: CircularSvgIcon(
            assetName: AppAssets.bellNotification,
            size: AppDimens.iconButtonSize,
            iconSize: 20,
            backgroundColor: AppColors.surfaceElevated,
            iconColor: AppColors.textPrimary,
            onTap: onNotificationTap,
          ),
        ),
      ],
    );
  }
}
