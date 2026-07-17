import 'dart:async';
import 'dart:math';
import 'package:injectable/injectable.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

abstract interface class DashboardRemoteDatasource {
  Future<DashboardModel> getDashboard();

  Stream<DashboardModel> watchDashboardUpdates(DashboardModel current);

  Future<CardModel> toggleFreezeCard({
    required String cardId,
    required bool freeze,
  });
}

@LazySingleton(as: DashboardRemoteDatasource)
class DashboardRemoteDatasourceImpl implements DashboardRemoteDatasource {
  final DioClient dioClient;
  final Random _random = Random();

  DashboardRemoteDatasourceImpl(this.dioClient);

  @override
  Future<DashboardModel> getDashboard() async {
    await Future.delayed(ApiConstants.mockNetworkDelay);
    return _seedDashboard();
  }

  @override
  Stream<DashboardModel> watchDashboardUpdates(DashboardModel current) async* {
    var latest = current;
    while (true) {
      await Future.delayed(AppDurationsAlias.realtimeTick);
      final balanceDeltaCents = _random.nextInt(4000) - 1500;
      final spendDeltaCents = _random.nextInt(600);

      final updatedTrend = List<SpendingPointModel>.from(
        latest.spendingTrend.map((e) => e),
      );
      if (updatedTrend.isNotEmpty) {
        final lastIndex = updatedTrend.length - 1;
        final last = updatedTrend[lastIndex];
        updatedTrend[lastIndex] = SpendingPointModel(
          month: last.month,
          value: (last.value + spendDeltaCents).clamp(0, 1 << 62),
        );
      }

      latest = DashboardModel(
        userName: latest.userName,
        email: latest.email,
        totalBalance: latest.totalBalance + balanceDeltaCents,
        totalSpending: latest.totalSpending + spendDeltaCents,
        spendingTrend: updatedTrend,
        cards: latest.cards,
        quickActions: latest.quickActions,
        transactions: latest.transactions,
        lastUpdated: DateTime.now(),
      );

      yield latest;
    }
  }

  @override
  Future<CardModel> toggleFreezeCard({
    required String cardId,
    required bool freeze,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final card = _seedDashboard().cards.firstWhere(
      (c) => c.id == cardId,
      orElse: () => _seedDashboard().cards.first,
    );
    return CardModel(
      id: card.id,
      holderName: card.holderName,
      maskedNumber: card.maskedNumber,
      validThru: card.validThru,
      cvv: card.cvv,
      isVirtual: card.isVirtual,
      isFrozen: freeze,
    );
  }

  DashboardModel _seedDashboard() {
    return DashboardModel(
      userName: 'Alex Morgan',
      email: 'alex.morgan@example.com',
      totalBalance: 120000,
      totalSpending: 120000,
      spendingTrend: [
        const SpendingPointModel(month: 'Jan', value: 90000),
        const SpendingPointModel(month: 'Feb', value: 365700),
        const SpendingPointModel(month: 'Mar', value: 240000),
        const SpendingPointModel(month: 'Apr', value: 310000),
        const SpendingPointModel(month: 'May', value: 390000),
        const SpendingPointModel(month: 'Jun', value: 330000),
      ],
      cards: [
        const CardModel(
          id: 'card_physical_1',
          holderName: 'Tayyab Sohail',
          maskedNumber: '●●●● ●●●● ●●●● 3466',
          validThru: '12/02/2024',
          cvv: '663',
          isVirtual: false,
        ),
        const CardModel(
          id: 'card_physical_1',
          holderName: 'Tayyab Sohail',
          maskedNumber: '●●●● ●●●● ●●●● 3466',
          validThru: '12/02/2024',
          cvv: '663',
          isVirtual: false,
        ),
        const CardModel(
          id: 'card_virtual_1',
          holderName: 'Tayyab Sohail',
          maskedNumber: '●●●● ●●●● ●●●● 8821',
          validThru: '08/09/2025',
          cvv: '204',
          isVirtual: true,
        ),
        const CardModel(
          id: 'card_virtual_1',
          holderName: 'Tayyab Sohail',
          maskedNumber: '●●●● ●●●● ●●●● 8821',
          validThru: '08/09/2025',
          cvv: '204',
          isVirtual: true,
        ),
        const CardModel(
          id: 'card_virtual_1',
          holderName: 'Tayyab Sohail',
          maskedNumber: '●●●● ●●●● ●●●● 8821',
          validThru: '08/09/2025',
          cvv: '204',
          isVirtual: true,
        ),
      ],
      quickActions: [
        const QuickActionModel(
          id: 'bill_pay',
          label: 'Bill Pay',
          iconName: 'bill_pay',
        ),
        const QuickActionModel(
          id: 'donations',
          label: 'Donations',
          iconName: 'donations',
        ),
        const QuickActionModel(
          id: 'deposit',
          label: 'Deposit',
          iconName: 'deposit',
        ),
        const QuickActionModel(id: 'more', label: 'More', iconName: 'more'),
      ],
      transactions: [
        TransactionModel(
          id: 'txn_1',
          title: 'E wallet',
          dateTime: DateTime(2024, 12, 12, 12, 10),
          amount: 100,
          isCredit: true,
          type: TransactionType.eWallet,
        ),
        TransactionModel(
          id: 'txn_2',
          title: 'Online Shopping',
          dateTime: DateTime(2024, 12, 12, 12, 10),
          amount: 100,
          isCredit: false,
          type: TransactionType.onlineShopping,
        ),
        TransactionModel(
          id: 'txn_3',
          title: 'E wallet',
          dateTime: DateTime(2024, 12, 12, 12, 10),
          amount: 100,
          isCredit: true,
          type: TransactionType.eWallet,
        ),
        TransactionModel(
          id: 'txn_4',
          title: 'Banking Fee',
          dateTime: DateTime(2024, 12, 12, 12, 10),
          amount: 100,
          isCredit: true,
          type: TransactionType.bankingFee,
        ),
        TransactionModel(
          id: 'txn_5',
          title: 'Saving',
          dateTime: DateTime(2024, 12, 12, 12, 10),
          amount: 200,
          isCredit: false,
          type: TransactionType.saving,
        ),
      ],
      lastUpdated: DateTime.now(),
    );
  }
}

abstract final class AppDurationsAlias {
  static const Duration realtimeTick = Duration(seconds: 6);
}
