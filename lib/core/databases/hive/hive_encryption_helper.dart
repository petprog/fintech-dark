import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class HiveEncryptionHelper {
  static const _keyName = 'hive_encryption_key';

  static Future<List<int>> getKey(FlutterSecureStorage storage) async {
    String? encodedKey = await storage.read(key: _keyName);

    if (encodedKey == null) {
      final key = Hive.generateSecureKey();

      encodedKey = base64UrlEncode(key);

      await storage.write(key: _keyName, value: encodedKey);
    }

    return base64Url.decode(encodedKey);
  }
}
