import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../core.dart';

abstract final class HiveInjectionNames {
  static const encryptionKey = 'hiveEncryptionKey';
}

@module
abstract class HiveModule {
  @preResolve
  @singleton
  @Named(HiveInjectionNames.encryptionKey)
  Future<List<int>> hiveEncryptionKey(FlutterSecureStorage storage) async {
    return HiveEncryptionHelper.getKey(storage);
  }

  @preResolve
  @Named(HiveBoxNames.accountBox)
  Future<Box<AccountModel>> accountBox(
    @Named(HiveInjectionNames.encryptionKey) List<int> key,
  ) async {
    return Hive.openBox<AccountModel>(
      HiveBoxes.account,
      encryptionCipher: HiveAesCipher(key),
    );
  }

  @preResolve
  @Named(HiveBoxNames.wallet)
  Future<Box<WalletModel>> walletBox(
    @Named(HiveInjectionNames.encryptionKey) List<int> key,
  ) async {
    return Hive.openBox<WalletModel>(
      HiveBoxes.wallet,
      encryptionCipher: HiveAesCipher(key),
    );
  }
}
