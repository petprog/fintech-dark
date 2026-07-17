import 'entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_entity.freezed.dart';

@freezed
abstract class DashboardEntity with _$DashboardEntity {
  const factory DashboardEntity({
    required String userName,
    required String email,
    required int totalBalance,
    required int totalSpending,
    required List<SpendingPointEntity> spendingTrend,
    required List<CardEntity> cards,
    required List<QuickActionEntity> quickActions,
    required List<TransactionEntity> transactions,
    required DateTime lastUpdated,
  }) = _DashboardEntity;
}
