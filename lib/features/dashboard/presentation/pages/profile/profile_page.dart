import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../common/common.dart';
import '../../../../../core/core.dart';
import '../../../../features.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _appNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);
    final userName = context.select<DashboardCubit, String>(
      (cubit) => switch (cubit.state) {
        DashboardLoaded(:final dashboard) => dashboard.userName,
        DashboardError(lastKnownGood: final d?) => d.userName,
        _ => '',
      },
    );

    final userEmail = context.select<DashboardCubit, String>(
      (cubit) => switch (cubit.state) {
        DashboardLoaded(:final dashboard) => dashboard.email,
        DashboardError(lastKnownGood: final d?) => d.email,
        _ => '',
      },
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: horizontalPadding,
        title: Text(
          AppStrings.profile,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    StaggeredEntrance(
                      child: Row(
                        children: [
                          Container(
                            width: 63,
                            height: 63,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.textOnPrimary,
                                width: 2,
                              ),
                            ),
                            child: const ClipOval(
                              child: SizedBox(
                                width: 59,
                                height: 59,
                                child: AppImage(
                                  assetName: AppAssets.avatar1,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppDimens.spaceS),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      userName.isEmpty ? '—' : userName,
                                      style: AppTextStyles.title,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(width: AppDimens.spaceXS),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppDimens.spaceXS,
                                        vertical: AppDimens.spaceXXXS,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.surfaceCard,
                                        borderRadius: BorderRadius.circular(
                                          AppDimens.radiusM,
                                        ),
                                        border: Border.all(
                                          color: AppColors.divider,
                                        ),
                                      ),
                                      child: Text(
                                        AppStrings.uxUiDesigner,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontSize: 9,
                                              color: AppColors.textPrimary,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  userEmail.isEmpty ? '—' : userEmail,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontSize: 11,
                                        color: AppColors.textPrimary,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimens.spaceXL),

                    StaggeredEntrance(
                      delay: AppDurations.cardStagger,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SettingsSectionLabel('Profile Settings'),
                          AppActionTile.arrow(
                            iconName: AppAssets.eStatement,
                            label: 'E-Statement',
                            onTap: () {},
                          ),
                          const SizedBox(height: AppDimens.spaceM),
                          AppActionTile.arrow(
                            iconName: AppAssets.creditCard,
                            label: 'Credit Card',
                            onTap: () {},
                          ),
                          const SizedBox(height: AppDimens.spaceM),
                          AppActionTile.arrow(
                            iconName: AppAssets.settings,
                            label: 'Settings',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimens.spaceXL),

                    StaggeredEntrance(
                      delay: AppDurations.cardStagger * 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SettingsSectionLabel('Notification'),
                          AppActionTile.switchTile(
                            iconName: AppAssets.bellNotification,
                            label: 'App Notification',
                            value: _appNotificationsEnabled,
                            onChanged: (value) => setState(
                              () => _appNotificationsEnabled = value,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimens.spaceXL),

                    StaggeredEntrance(
                      delay: AppDurations.cardStagger * 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SettingsSectionLabel('More'),
                          AppActionTile.arrow(
                            iconName: AppAssets.language,
                            label: 'Language',
                            onTap: () {},
                          ),
                          const SizedBox(height: AppDimens.spaceM),
                          AppActionTile.arrow(
                            iconName: AppAssets.country,
                            label: 'Country',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimens.spaceS),
                    const SizedBox(height: AppDimens.spaceL),

                    StaggeredEntrance(
                      delay: AppDurations.cardStagger * 4,
                      child: Row(
                        children: [
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
                    const SizedBox(height: AppDimens.spaceXXL),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
