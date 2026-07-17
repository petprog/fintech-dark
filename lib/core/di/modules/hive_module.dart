import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HiveModule {
  @preResolve
  Future<Box> openSettingsBox() async {
    await Hive.initFlutter();

    return Hive.openBox('settings');
  }
}
