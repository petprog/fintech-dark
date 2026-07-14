import '../../../features.dart';

class DashboardModel extends DashboardEntity {
  const DashboardModel({
    required super.userName,
    required super.email,
    required super.totalBalance,
    required super.totalSpending,
    required super.spendingTrend,
    required super.cards,
    required super.quickActions,
    required super.transactions,
    required super.lastUpdated,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      userName: json['userName'] as String,
      email: json['email'] as String,
      totalBalance: (json['totalBalance'] as num).toDouble(),
      totalSpending: (json['totalSpending'] as num).toDouble(),
      spendingTrend: (json['spendingTrend'] as List)
          .map((e) => SpendingPointModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cards: (json['cards'] as List)
          .map((e) => CardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      quickActions: (json['quickActions'] as List)
          .map((e) => QuickActionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      transactions: (json['transactions'] as List)
          .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'email': email,
    'totalBalance': totalBalance,
    'totalSpending': totalSpending,
    'spendingTrend': spendingTrend
        .map((e) => (e as SpendingPointModel).toJson())
        .toList(),
    'cards': cards.map((e) => (e as CardModel).toJson()).toList(),
    'quickActions': quickActions
        .map((e) => (e as QuickActionModel).toJson())
        .toList(),
    'transactions': transactions
        .map((e) => (e as TransactionModel).toJson())
        .toList(),
    'lastUpdated': lastUpdated.toIso8601String(),
  };

  @override
  DashboardModel copyWith({
    String? userName,
    String? email,
    double? totalBalance,
    double? totalSpending,
    List<SpendingPointEntity>? spendingTrend,
    List<CardEntity>? cards,
    List<QuickActionEntity>? quickActions,
    List<TransactionEntity>? transactions,
    DateTime? lastUpdated,
  }) {
    return DashboardModel(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      totalBalance: totalBalance ?? this.totalBalance,
      totalSpending: totalSpending ?? this.totalSpending,
      spendingTrend: (spendingTrend ?? this.spendingTrend)
          .cast<SpendingPointModel>(),
      cards: (cards ?? this.cards).cast<CardModel>(),
      quickActions: (quickActions ?? this.quickActions)
          .cast<QuickActionModel>(),
      transactions: (transactions ?? this.transactions)
          .cast<TransactionModel>(),
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
