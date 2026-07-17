import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

@freezed
@HiveType(typeId: 1)
abstract class WalletModel with _$WalletModel {
  const factory WalletModel({
    @HiveField(0) required String id,
    @HiveField(1) required double balance,
    @HiveField(2) required String currency,
    @HiveField(3) required DateTime lastUpdated,
  }) = _WalletModel;

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);
}
