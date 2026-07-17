import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';

import '../core/core.dart';

class AppBootstrap {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _initializeHive();
    await configureDependencies(Environment.dev);
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
