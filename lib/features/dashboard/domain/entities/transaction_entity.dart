import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_entity.freezed.dart';

enum TransactionType { eWallet, onlineShopping, bankingFee, saving, transfer }

@freezed
abstract class TransactionEntity with _$TransactionEntity {
  const factory TransactionEntity({
    required String id,
    required String title,
    required DateTime dateTime,
    required double amount,
    required bool isCredit,
    required TransactionType type,
  }) = _TransactionEntity;
}
