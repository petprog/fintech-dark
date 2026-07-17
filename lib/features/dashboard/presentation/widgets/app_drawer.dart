import 'package:fintech_dark/common/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class AppDrawer extends StatelessWidget {
  final String userName;

  const AppDrawer({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.spaceL,
                AppDimens.spaceL,
                AppDimens.spaceL,
                AppDimens.spaceM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _navigate(context, AppRoutes.profile),
                    child: const Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 59,
                            height: 59,
                            child: AppImage(
                              assetName: AppAssets.avatar1,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -2,
                          right: -2,
                          child: CircularSvgIcon(
                            assetName: AppAssets.editPencil,
                            size: 16,
                            iconSize: 11,
                            backgroundColor: Colors.white,
                            iconColor: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimens.spaceXS),
                  Text(
                    AppStrings.welcomeMessage,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.spaceM,
                AppDimens.spaceM,
                AppDimens.spaceS,
                AppDimens.spaceS,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.profileSettings,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppDimens.spaceM),
                  AppActionTile.arrow(
                    iconName: AppAssets.eStatement,
                    label: AppStrings.eStatement,
                    onTap: () {},
                  ),
                  const SizedBox(height: AppDimens.spaceM),

                  AppActionTile.arrow(
                    iconName: AppAssets.creditCard,
                    label: AppStrings.creditCard,
                    onTap: () => _navigate(context, AppRoutes.card),
                  ),
                  const SizedBox(height: AppDimens.spaceM),

                  AppActionTile.arrow(
                    iconName: AppAssets.settings,
                    label: AppStrings.settings,
                    onTap: () {},
                  ),
                  const SizedBox(height: AppDimens.spaceM),
                  Text(
                    AppStrings.notification,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppDimens.spaceM),
                  AppActionTile.switchTile(
                    iconName: AppAssets.bellNotification,
                    label: AppStrings.appNotification,
                    value: true,
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: AppDimens.spaceM),
                  Text(
                    AppStrings.more,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppDimens.spaceM),
                  AppActionTile.arrow(
                    iconName: AppAssets.language,
                    label: AppStrings.language,
                    onTap: () {},
                  ),
                  const SizedBox(height: AppDimens.spaceM),

                  AppActionTile.arrow(
                    iconName: AppAssets.country,
                    label: AppStrings.country,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: AppDimens.spaceL),
                  ElevatedButton.icon(
                    iconAlignment: IconAlignment.end,
                    style: ElevatedButton.styleFrom(
                      textStyle: AppTextStyles.button.copyWith(
                        color: AppColors.error,
                      ),
                      backgroundColor: const Color(0xFFFFD4D4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.spaceS,
                        vertical: AppDimens.spaceXS,
                      ),
                    ),

                    onPressed: () {},
                    icon: const AppSvg(
                      assetName: AppAssets.logOut,
                      width: 24,
                      height: 24,
                    ),
                    label: Text(
                      AppStrings.logOut,
                      style: AppTextStyles.button.copyWith(
                        color: const Color(0xFF5A0000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigate(BuildContext context, String route) {
    Navigator.of(context).pop();
    context.push(route);
  }
}
