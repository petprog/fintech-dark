import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppImage extends StatelessWidget {
  final String assetName;
  final double? width;
  final double? height;
  final double? size;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Alignment alignment;

  const AppImage({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.size,
    this.alignment = Alignment.center,
  });

  bool _isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null &&
        uri.hasScheme &&
        (uri.scheme == 'http' || uri.scheme == 'https');
  }

  Widget _defaultPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: size ?? width,
        height: size ?? height,
        color: Colors.white,
      ),
    );
  }

  Widget _defaultErrorWidget() {
    return Container(
      width: size ?? width,
      height: size ?? height,
      color: Colors.grey[200],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isValidUrl(assetName)) {
      // Use CachedNetworkImage for remote images
      return CachedNetworkImage(
        alignment: alignment,
        imageUrl: assetName,
        width: size ?? width,
        height: size ?? height,
        fit: fit,
        placeholder: (context, url) => placeholder ?? _defaultPlaceholder(),
        errorWidget: (context, url, error) =>
            errorWidget ?? _defaultErrorWidget(),
      );
    } else {
      // Use Image.asset for local images
      return Image.asset(
        alignment: alignment,
        assetName,
        width: size ?? width,
        height: size ?? height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _defaultErrorWidget(),
      );
    }
  }
}
