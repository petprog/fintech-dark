import 'package:equatable/equatable.dart';

enum TransactionType { eWallet, onlineShopping, bankingFee, saving, transfer }

class TransactionEntity extends Equatable {
  final String id;
  final String title;
  final DateTime dateTime;
  final double amount;
  final bool isCredit;
  final TransactionType type;

  const TransactionEntity({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.amount,
    required this.isCredit,
    required this.type,
  });

  @override
  List<Object?> get props => [id, title, dateTime, amount, isCredit, type];
}
