import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../core.dart';

@module
abstract class HiveModule {
  @preResolve
  @Named('accountBox')
  Future<Box<AccountModel>> accountBox(FlutterSecureStorage storage) async {
    final key = await HiveEncryptionHelper.getKey(storage);

    return Hive.openBox<AccountModel>(
      HiveBoxes.account,
      encryptionCipher: HiveAesCipher(key),
    );
  }

  @preResolve
  @Named('walletBox')
  Future<Box<WalletModel>> walletBox(FlutterSecureStorage storage) async {
    final key = await HiveEncryptionHelper.getKey(storage);

    return Hive.openBox<WalletModel>(
      HiveBoxes.wallet,
      encryptionCipher: HiveAesCipher(key),
    );
  }
}
