import 'dart:ui';

import 'package:fintech_dark/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';

import '../core/core.dart';

class AppBootstrap {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _initializeHive();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await configureDependencies(Environment.dev);

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  static Future<void> _initializeHive() async {
    await Hive.initFlutter();

    _registerHiveAdapters();
  }

  static void _registerHiveAdapters() {
    Hive.registerAdapter(AccountModelAdapter());
    Hive.registerAdapter(WalletModelAdapter());
  }
}
