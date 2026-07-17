import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@module
abstract class StorageModule {
  @preResolve
  Future<SharedPreferences> provideSharedPreferences() async {
    return SharedPreferences.getInstance();
  }
}
