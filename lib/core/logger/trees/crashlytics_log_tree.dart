import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'log_tree.dart';

class CrashlyticsLogTree implements LogTree {
  final FirebaseCrashlytics crashlytics;

  CrashlyticsLogTree(this.crashlytics);

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    switch (level) {
      case LogLevel.error:
        crashlytics.recordError(error ?? message, stackTrace, reason: message);

      case LogLevel.warning:
      case LogLevel.info:
      case LogLevel.debug:
        crashlytics.log('[${level.name}] $message');
    }
  }
}
