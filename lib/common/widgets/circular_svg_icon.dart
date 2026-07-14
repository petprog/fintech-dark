import 'package:flutter/material.dart';

import '../common.dart';

class CircularSvgIcon extends StatelessWidget {
  const CircularSvgIcon({
    super.key,
    required this.assetName,
    this.size = 48,
    this.iconSize = 24,
    this.backgroundColor = const Color(0xFF2E2E2E),
    this.iconColor = Colors.white,
    this.borderColor,
    this.onTap,
  });

  final String assetName;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final widget = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: borderColor != null ? Border.all(color: borderColor!) : null,
      ),
      child: Center(
        child: AppSvg(assetName: assetName, size: iconSize, color: iconColor),
      ),
    );

    return onTap != null
        ? InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: widget,
          )
        : widget;
  }
}
