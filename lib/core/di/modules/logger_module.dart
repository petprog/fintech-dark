import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../core.dart';

@module
abstract class LoggerModule {
  @lazySingleton
  ConsoleLogTree consoleLogTree() {
    return ConsoleLogTree();
  }

  @lazySingleton
  CrashlyticsLogTree crashlyticsLogTree(FirebaseCrashlytics crashlytics) {
    return CrashlyticsLogTree(crashlytics);
  }

  @lazySingleton
  List<LogTree> logTrees(
    ConsoleLogTree consoleTree,
    CrashlyticsLogTree crashlyticsTree,
  ) {
    if (kDebugMode) {
      return [consoleTree];
    }

    return [crashlyticsTree];
  }
}
