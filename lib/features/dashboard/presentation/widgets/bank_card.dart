import 'package:fintech_dark/common/common.dart';
import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class BankCard extends StatelessWidget {
  final CardEntity card;

  const BankCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: card.isFrozen ? 0.55 : 1,
      child: Container(
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
            const AppImage(assetName: AppAssets.chip, width: 68, height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.spaceS),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.maskedNumber,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: AppDimens.spaceXS),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _cardMeta('Card Holder', card.holderName),
                      _cardMeta('Valid', card.validThru),
                      _cardMeta('CVV', card.cvv),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardMeta(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodySecondary.copyWith(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
