import 'package:flutter/material.dart';
import '../../../../common/common.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final VoidCallback onAddCash;
  final VoidCallback onSendMoney;

  const BalanceCard({
    super.key,
    required this.balance,
    required this.onAddCash,
    required this.onSendMoney,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.spaceXS),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
        border: Border.all(color: AppColors.divider),
        image: const DecorationImage(
          image: AssetImage(AppAssets.cardBackgroundDark),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppSvg(
                assetName: AppAssets.mastercardLogo,
                width: 42,
                height: 32,
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.spaceM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.totalBalance,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(fontSize: 20),
                        ),
                        const SizedBox(height: AppDimens.spaceXS),
                        AnimatedAmount(
                          value: balance,
                          style: AppTextStyles.balance,
                        ),
                      ],
                    ),
                    const CircularSvgIcon(
                      assetName: AppAssets.qrCode,
                      iconSize: 22,
                      size: 38,
                    ),
                  ],
                ),

                const SizedBox(height: AppDimens.spaceL),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onAddCash,
                        icon: const AppSvg(
                          assetName: AppAssets.addPlus,
                          width: 24,
                          height: 24,
                        ),
                        label: const Text(AppStrings.addCash),
                      ),
                    ),
                    const SizedBox(width: AppDimens.spaceM),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onSendMoney,
                        icon: const AppSvg(
                          assetName: AppAssets.arrowUpLeft,
                          width: 24,
                          height: 24,
                        ),
                        label: const Text(AppStrings.sendMoney),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimens.spaceL),
        ],
      ),
    );
  }
}
