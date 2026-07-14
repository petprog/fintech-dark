import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

enum DeviceType { smallPhone, largePhone, tablet }

abstract final class ResponsiveUtils {
  static DeviceType deviceTypeOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= AppConstants.tabletMaxWidth) return DeviceType.tablet;
    if (width >= AppConstants.mobileMaxWidth) return DeviceType.largePhone;
    return DeviceType.smallPhone;
  }

  static bool isTablet(BuildContext context) =>
      deviceTypeOf(context) == DeviceType.tablet;

  static double horizontalPadding(BuildContext context) {
    switch (deviceTypeOf(context)) {
      case DeviceType.smallPhone:
        return 16;
      case DeviceType.largePhone:
        return 20;
      case DeviceType.tablet:
        return 40;
    }
  }

  static int gridColumns(BuildContext context) {
    switch (deviceTypeOf(context)) {
      case DeviceType.smallPhone:
        return 4;
      case DeviceType.largePhone:
        return 4;
      case DeviceType.tablet:
        return 6;
    }
  }

  static double maxContentWidth(BuildContext context) =>
      isTablet(context) ? 720 : double.infinity;
}
