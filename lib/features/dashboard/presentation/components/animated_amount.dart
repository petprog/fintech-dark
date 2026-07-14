import 'package:flutter/material.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/formatters.dart';

class AnimatedAmount extends StatefulWidget {
  final double value;
  final TextStyle? style;

  const AnimatedAmount({
    super.key,
    required this.value,
    this.style = AppTextStyles.balance,
  });

  @override
  State<AnimatedAmount> createState() => _AnimatedAmountState();
}

class _AnimatedAmountState extends State<AnimatedAmount> {
  late double _previousValue = widget.value;

  @override
  void didUpdateWidget(covariant AnimatedAmount oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(widget.value),
      tween: Tween<double>(begin: _previousValue, end: widget.value),
      duration: AppDurations.numberTween,
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, _) {
        return Text(
          Formatters.currency(animatedValue),
          style: widget.style?.copyWith(letterSpacing: -.4),
        );
      },
    );
  }
}
