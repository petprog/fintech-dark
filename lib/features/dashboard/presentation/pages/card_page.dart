import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/app.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  bool showVirtualCards = false;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveUtils.horizontalPadding(context);

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
          AppStrings.yourCard,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded),
          ),
          SizedBox(width: horizontalPadding),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                final cards = switch (state) {
                  DashboardLoaded(:final dashboard) => dashboard.cards,
                  DashboardError(lastKnownGood: final d?) => d.cards,
                  _ => const <CardEntity>[],
                };

                if (cards.isEmpty) {
                  return const SizedBox.shrink();
                }

                final physicalCards = cards.where((c) => !c.isVirtual).length;
                final virtualCards = cards.where((c) => c.isVirtual).length;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.spaceM,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$physicalCards Physical Card, $virtualCards Virtual Card',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),

                      const SizedBox(height: AppDimens.spaceM),

                      Row(
                        children: [
                          _CardTypeChip(
                            label: 'Physical Card',
                            count: physicalCards,
                            isActive: !showVirtualCards,
                            onTap: () {
                              setState(() {
                                showVirtualCards = false;
                              });
                            },
                          ),
                          const SizedBox(width: AppDimens.spaceS),
                          _CardTypeChip(
                            label: 'Virtual Card',
                            count: virtualCards,
                            isActive: showVirtualCards,
                            onTap: () {
                              setState(() {
                                showVirtualCards = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: AppDimens.spaceL),
            Expanded(
              child: ListView(
                children: [
                  StaggeredEntrance(
                    child: BlocBuilder<DashboardCubit, DashboardState>(
                      builder: (context, state) {
                        final cubit = context.read<DashboardCubit>();
                        final cards = switch (state) {
                          DashboardLoaded(:final dashboard) => dashboard.cards,
                          DashboardError(lastKnownGood: final d?) => d.cards,
                          _ => const <CardEntity>[],
                        };
                        if (cards.isEmpty) return const SizedBox.shrink();
                        final filteredCards = cards
                            .where((card) => card.isVirtual == showVirtualCards)
                            .toList();

                        if (filteredCards.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return CardCarousel(
                          cards: filteredCards,
                          onFreezeToggle: (card) =>
                              cubit.toggleFreezeCard(card.id),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppDimens.spaceL),
                  StaggeredEntrance(
                    delay: AppDurations.cardStagger,
                    child: BlocBuilder<DashboardCubit, DashboardState>(
                      builder: (context, state) {
                        final cubit = context.read<DashboardCubit>();
                        final cards = switch (state) {
                          DashboardLoaded(:final dashboard) => dashboard.cards,
                          DashboardError(lastKnownGood: final d?) => d.cards,
                          _ => const <CardEntity>[],
                        };
                        if (cards.isEmpty) return const SizedBox.shrink();
                        final firstCard = cards.first;
                        return CardSettingsQuickRow(
                          isFrozen: firstCard.isFrozen,
                          onFreezeToggle: () =>
                              cubit.toggleFreezeCard(firstCard.id),
                          onReveal: () {},
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppDimens.spaceM),
                  const Divider(height: 0),
                  const SizedBox(height: AppDimens.spaceM),
                  StaggeredEntrance(
                    delay: AppDurations.cardStagger * 2,
                    child: BlocBuilder<CardSettingsCubit, CardSettingsState>(
                      builder: (context, settings) {
                        final cubit = context.read<CardSettingsCubit>();
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.spaceM,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SettingsSectionLabel('Card Settings'),
                              const SizedBox(height: AppDimens.spaceS),
                              AppActionTile.switchTile(
                                iconName: AppAssets.changePin,
                                label: 'Change Pin',
                                value: settings.changePinEnabled,
                                onChanged: cubit.toggleChangePin,
                              ),
                              const SizedBox(height: AppDimens.spaceL),
                              AppActionTile.switchTile(
                                iconName: AppAssets.qrPayment,
                                label: 'QR Payment',
                                value: settings.qrPaymentEnabled,
                                onChanged: cubit.toggleQrPayment,
                              ),
                              const SizedBox(height: AppDimens.spaceL),
                              AppActionTile.switchTile(
                                iconName: AppAssets.shop,
                                label: 'Online Shopping',
                                value: settings.onlineShoppingEnabled,
                                onChanged: cubit.toggleOnlineShopping,
                              ),
                              const SizedBox(height: AppDimens.spaceL),
                              AppActionTile.arrow(
                                iconName: AppAssets.cardTransactions,
                                label: 'Card Transactions',
                                onTap: () =>
                                    context.push(AppRoutes.cardTransaction),
                              ),
                              const SizedBox(height: AppDimens.spaceL),
                              AppActionTile.switchTile(
                                iconName: AppAssets.tapPay,
                                label: 'Tap Pay',
                                value: settings.tapPayEnabled,
                                onChanged: cubit.toggleTapPay,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppDimens.spaceXXL),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardTypeChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isActive;
  final VoidCallback onTap;

  const _CardTypeChip({
    required this.label,
    required this.count,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spaceM,
          vertical: AppDimens.spaceXS,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: isActive
              ? Border.all(color: AppColors.primary, width: 1.5)
              : null,
          color: isActive ? AppColors.surface : AppColors.surfaceCard,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
