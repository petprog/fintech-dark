abstract final class AppDimens {
  static const double spaceXXS = 4;
  static const double spaceXS = 8;
  static const double spaceS = 12;
  static const double spaceM = 16;
  static const double spaceL = 20;
  static const double spaceXL = 24;
  static const double spaceXXL = 32;

  static const double radiusS = 8;
  static const double radiusM = 12;
  static const double radiusL = 16;
  static const double radiusXL = 24;
  static const double radiusPill = 100;

  static const double cardElevation = 0;
  static const double iconButtonSize = 40;
}

abstract final class AppDurations {
  static const Duration pageEntrance = Duration(milliseconds: 500);
  static const Duration cardStagger = Duration(milliseconds: 90);
  static const Duration cardAppear = Duration(milliseconds: 400);
  static const Duration stateTransition = Duration(milliseconds: 300);
  static const Duration numberTween = Duration(milliseconds: 600);
  static const Duration shimmerLoop = Duration(milliseconds: 1400);
  static const Duration realtimeTick = Duration(seconds: 6);
}
