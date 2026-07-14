import 'package:flutter/material.dart';
import '../../../../common/common.dart';
import '../../../../core/core.dart';

class RecentTransferRow extends StatelessWidget {
  final List<String> initials;
  final VoidCallback onAddTap;

  const RecentTransferRow({
    super.key,
    required this.initials,
    required this.onAddTap,
  });

  static const List<Color> _palette = [
    AppColors.primary,
    AppColors.success,
    AppColors.warning,
    AppColors.primaryGradientEnd,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spaceM),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
        border: Border.all(color: AppColors.divider),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Transfer',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),

              const SizedBox(height: AppDimens.spaceS),

              SizedBox(
                height: 48,
                child: Stack(
                  children: [
                    for (var i = 0; i < initials.length; i++)
                      Positioned(
                        left: i * 32,
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.background,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: _palette[i % _palette.length],
                            child: Text(
                              initials[i],
                              style: AppTextStyles.body.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: onAddTap,
              child: const CircularSvgIcon(
                size: 36,
                assetName: AppAssets.addPlus,
                iconSize: 28,
                iconColor: Color(0xFF96C0FF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
