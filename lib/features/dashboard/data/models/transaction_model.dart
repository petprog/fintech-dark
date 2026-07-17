import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../features.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
abstract class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required String title,
    required DateTime dateTime,
    required double amount,
    required bool isCredit,
    required TransactionType type,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}

extension TransactionModelMapper on TransactionModel {
  TransactionEntity toEntity() => TransactionEntity(
    id: id,
    title: title,
    dateTime: dateTime,
    amount: amount,
    isCredit: isCredit,
    type: type,
  );
}

extension TransactionEntityMapper on TransactionEntity {
  TransactionModel toModel() => TransactionModel(
    id: id,
    title: title,
    dateTime: dateTime,
    amount: amount,
    isCredit: isCredit,
    type: type,
  );
}
