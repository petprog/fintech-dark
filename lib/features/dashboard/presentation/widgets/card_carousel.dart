import 'package:fintech_dark/common/common.dart';
import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../features.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CardCarousel extends StatefulWidget {
  final List<CardEntity> cards;
  final void Function(CardEntity) onFreezeToggle;

  const CardCarousel({
    super.key,
    required this.cards,
    required this.onFreezeToggle,
  });

  @override
  State<CardCarousel> createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.cards.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.cards.length,
          itemBuilder: (context, index, realIndex) {
            final card = widget.cards[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spaceXXS,
              ),
              child: BankCard(key: ValueKey(card.id), card: card),
            );
          },
          options: CarouselOptions(
            height: 160,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            enableInfiniteScroll: widget.cards.length > 1,
            autoPlay: false,
            onPageChanged: (index, reason) {
              setState(() => _currentPage = index);
            },
          ),
        ),

        const SizedBox(height: AppDimens.spaceS),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.cards.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == _currentPage ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: i == _currentPage
                    ? AppColors.primary
                    : AppColors.divider,
                borderRadius: BorderRadius.circular(AppDimens.radiusPill),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardSettingsQuickRow extends StatelessWidget {
  final bool isFrozen;
  final VoidCallback onFreezeToggle;
  final VoidCallback onReveal;

  const CardSettingsQuickRow({
    super.key,
    required this.isFrozen,
    required this.onFreezeToggle,
    required this.onReveal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickIconAction(
            iconName: isFrozen ? AppAssets.freezeCard : AppAssets.freezeCard,
            label: isFrozen ? 'Unfreeze' : 'Freeze Card',
            onTap: onFreezeToggle,
            highlighted: isFrozen,
          ),
        ),
        const SizedBox(width: AppDimens.spaceS),
        Expanded(
          child: _QuickIconAction(
            iconName: AppAssets.visualBlind,
            label: 'Reveal',
            onTap: onReveal,
          ),
        ),
        const SizedBox(width: AppDimens.spaceS),
        Expanded(
          child: _QuickIconAction(
            iconName: isFrozen ? AppAssets.freezeCard : AppAssets.freezeCard,
            label: isFrozen ? 'Unfreeze' : 'Freeze Card',
            onTap: onFreezeToggle,
            highlighted: isFrozen,
          ),
        ),
      ],
    );
  }
}

class _QuickIconAction extends StatelessWidget {
  final String iconName;
  final String label;
  final VoidCallback onTap;
  final bool highlighted;

  const _QuickIconAction({
    required this.iconName,
    required this.label,
    required this.onTap,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppDimens.radiusM),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.spaceS),
        child: Column(
          children: [
            CircularSvgIcon(
              assetName: iconName,
              iconColor: highlighted
                  ? AppColors.primary
                  : AppColors.textPrimary,
              size: 46,
              iconSize: 24,
            ),
            const SizedBox(height: AppDimens.spaceXS),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textPrimary,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
