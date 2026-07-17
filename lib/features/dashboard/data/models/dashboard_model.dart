import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../features.dart';

part 'dashboard_model.freezed.dart';
part 'dashboard_model.g.dart';

@freezed
abstract class DashboardModel with _$DashboardModel {
  const factory DashboardModel({
    required String userName,
    required String email,
    required double totalBalance,
    required double totalSpending,
    required List<SpendingPointModel> spendingTrend,
    required List<CardModel> cards,
    required List<QuickActionModel> quickActions,
    required List<TransactionModel> transactions,
    required DateTime lastUpdated,
  }) = _DashboardModel;

  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);
}

extension DashboardModelMapper on DashboardModel {
  DashboardEntity toEntity() => DashboardEntity(
    userName: userName,
    email: email,
    totalBalance: totalBalance,
    totalSpending: totalSpending,
    spendingTrend: spendingTrend.map((e) => e.toEntity()).toList(),
    cards: cards.map((e) => e.toEntity()).toList(),
    quickActions: quickActions.map((e) => e.toEntity()).toList(),
    transactions: transactions.map((e) => e.toEntity()).toList(),
    lastUpdated: lastUpdated,
  );
}

extension DashboardEntityMapper on DashboardEntity {
  DashboardModel toModel() => DashboardModel(
    userName: userName,
    email: email,
    totalBalance: totalBalance,
    totalSpending: totalSpending,
    spendingTrend: spendingTrend.map((e) => e.toModel()).toList(),
    cards: cards.map((e) => e.toModel()).toList(),
    quickActions: quickActions.map((e) => e.toModel()).toList(),
    transactions: transactions.map((e) => e.toModel()).toList(),
    lastUpdated: lastUpdated,
  );
}
