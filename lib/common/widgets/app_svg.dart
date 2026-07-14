import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvg extends StatelessWidget {
  final String assetName;
  final double? width;
  final double? height;
  final double? size;
  final Color? color;
  final BoxFit? fit;

  const AppSvg({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    this.size,
    this.color,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: size ?? width,
      height: size ?? height,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      fit: fit ?? BoxFit.contain,
    );
  }
}
