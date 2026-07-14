import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';

class ShimmerBox extends StatefulWidget {
  final double height;
  final double? width;
  final double borderRadius;

  const ShimmerBox({
    super.key,
    required this.height,
    this.width,
    this.borderRadius = AppDimens.radiusS,
  });

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.shimmerLoop,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(-1 + t * 3, 0),
              end: Alignment(0 + t * 3, 0),
              colors: const [
                AppColors.shimmerBase,
                AppColors.shimmerHighlight,
                AppColors.shimmerBase,
              ],
              stops: const [0.35, 0.5, 0.65],
            ),
          ),
        );
      },
    );
  }
}

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppDimens.spaceM),
      children: [
        const Row(
          children: [
            ShimmerBox(height: 44, width: 44, borderRadius: 22),
            SizedBox(width: AppDimens.spaceS),
            Expanded(child: ShimmerBox(height: 16, width: 140)),
          ],
        ),
        const SizedBox(height: AppDimens.spaceL),
        const ShimmerBox(height: 180, borderRadius: AppDimens.radiusL),
        const SizedBox(height: AppDimens.spaceL),
        Row(
          children: List.generate(
            4,
            (i) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: i == 3 ? 0 : AppDimens.spaceS),
                child: const ShimmerBox(
                  height: 72,
                  borderRadius: AppDimens.radiusM,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimens.spaceL),
        const ShimmerBox(height: 220, borderRadius: AppDimens.radiusL),
        const SizedBox(height: AppDimens.spaceL),
        ...List.generate(
          4,
          (i) => const Padding(
            padding: EdgeInsets.only(bottom: AppDimens.spaceS),
            child: ShimmerBox(height: 56, borderRadius: AppDimens.radiusM),
          ),
        ),
      ],
    );
  }
}
