import '../../../features.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.title,
    required super.dateTime,
    required super.amount,
    required super.isCredit,
    required super.type,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      amount: (json['amount'] as num).toDouble(),
      isCredit: json['isCredit'] as bool,
      type: TransactionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TransactionType.eWallet,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'dateTime': dateTime.toIso8601String(),
    'amount': amount,
    'isCredit': isCredit,
    'type': type.name,
  };
}
