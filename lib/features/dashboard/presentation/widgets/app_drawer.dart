import 'package:fintech_dark/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class AppDrawer extends StatelessWidget {
  final bool isPermanent;

  const AppDrawer({super.key, this.isPermanent = false});

  @override
  Widget build(BuildContext context) {
    final userName = context.select<DashboardCubit, String>(
      (cubit) => switch (cubit.state) {
        DashboardLoaded(:final dashboard) => dashboard.userName,
        DashboardError(lastKnownGood: final d?) => d.userName,
        _ => '',
      },
    );
    final content = SafeArea(
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
                  onTap: () => _navigate(context, const ProfileRoute()),

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
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontSize: 12),
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
                _sectionTitle(context, AppStrings.profileSettings),

                AppActionTile.arrow(
                  iconName: AppAssets.eStatement,
                  label: AppStrings.eStatement,

                  onTap: () => _navigate(context, const EStatementRoute()),
                ),

                const SizedBox(height: AppDimens.spaceM),

                AppActionTile.arrow(
                  iconName: AppAssets.creditCard,
                  label: AppStrings.creditCard,

                  onTap: () => _navigate(context, const CardsRoute()),
                ),

                const SizedBox(height: AppDimens.spaceM),

                AppActionTile.arrow(
                  iconName: AppAssets.settings,
                  label: AppStrings.settings,

                  onTap: () => _navigate(context, const SettingsRoute()),
                ),

                const SizedBox(height: AppDimens.spaceL),

                _sectionTitle(context, AppStrings.notification),

                AppActionTile.switchTile(
                  iconName: AppAssets.bellNotification,
                  label: AppStrings.appNotification,
                  value: true,
                  onChanged: (_) {},
                ),

                const SizedBox(height: AppDimens.spaceL),

                _sectionTitle(context, AppStrings.more),

                AppActionTile.arrow(
                  iconName: AppAssets.language,
                  label: AppStrings.language,

                  onTap: () => _navigate(context, const LanguageRoute()),
                ),

                const SizedBox(height: AppDimens.spaceM),

                AppActionTile.arrow(
                  iconName: AppAssets.country,
                  label: AppStrings.country,

                  onTap: () => _navigate(context, const CountryRoute()),
                ),

                const SizedBox(height: AppDimens.spaceL),

                ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,

                  style: ElevatedButton.styleFrom(
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
    );

    if (!isPermanent) {
      return Drawer(
        width: MediaQuery.sizeOf(context).width * 0.8,
        backgroundColor: AppColors.surface,
        child: content,
      );
    }

    return Container(width: 280, color: AppColors.surface, child: content);
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.spaceM),

      child: Text(
        title,

        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _navigate(BuildContext context, GoRouteData route) {
    if (!isPermanent) {
      Navigator.of(context).pop();
    }
    route.go(context);
  }
}
