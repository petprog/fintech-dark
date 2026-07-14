import 'package:equatable/equatable.dart';
import 'entities.dart';

class DashboardEntity extends Equatable {
  final String userName;
  final String email;
  final double totalBalance;
  final double totalSpending;
  final List<SpendingPointEntity> spendingTrend;
  final List<CardEntity> cards;
  final List<QuickActionEntity> quickActions;
  final List<TransactionEntity> transactions;
  final DateTime lastUpdated;

  const DashboardEntity({
    required this.userName,
    required this.email,
    required this.totalBalance,
    required this.totalSpending,
    required this.spendingTrend,
    required this.cards,
    required this.quickActions,
    required this.transactions,
    required this.lastUpdated,
  });

  DashboardEntity copyWith({
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
    return DashboardEntity(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      totalBalance: totalBalance ?? this.totalBalance,
      totalSpending: totalSpending ?? this.totalSpending,
      spendingTrend: spendingTrend ?? this.spendingTrend,
      cards: cards ?? this.cards,
      quickActions: quickActions ?? this.quickActions,
      transactions: transactions ?? this.transactions,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [
    userName,
    totalBalance,
    totalSpending,
    spendingTrend,
    cards,
    quickActions,
    transactions,
    lastUpdated,
  ];
}
