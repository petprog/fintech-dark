import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
@HiveType(typeId: 0)
abstract class AccountModel with _$AccountModel {
  const factory AccountModel({
    @HiveField(0) required String id,
    @HiveField(1) required String accountNumber,
    @HiveField(2) required String accountName,
    @HiveField(3) required String bankName,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
}
