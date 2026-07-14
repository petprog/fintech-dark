import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../features.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  final GetDashboardUsecase getDashboardUsecase;
  final WatchDashboardUpdatesUsecase watchDashboardUpdatesUsecase;
  final ToggleFreezeCardUsecase toggleFreezeCardUsecase;

  StreamSubscription? _realtimeSubscription;

  DashboardCubit({
    required this.getDashboardUsecase,
    required this.watchDashboardUpdatesUsecase,
    required this.toggleFreezeCardUsecase,
  }) : super(const DashboardInitial());

  Future<void> loadDashboard() async {
    emit(const DashboardLoading());
    final result = await getDashboardUsecase();

    result.fold((failure) => emit(DashboardError(failure.message)), (
      dashboard,
    ) {
      emit(DashboardLoaded(dashboard: dashboard));
      _startRealtimeUpdates(dashboard);
    });
  }

  Future<void> refresh() async {
    final current = state;
    if (current is DashboardLoaded) {
      emit(current.copyWith(isRefreshing: true));
    } else {
      emit(const DashboardLoading());
    }

    final result = await getDashboardUsecase();

    result.fold(
      (failure) {
        final lastGood = current is DashboardLoaded ? current.dashboard : null;
        emit(DashboardError(failure.message, lastKnownGood: lastGood));
      },
      (dashboard) {
        emit(DashboardLoaded(dashboard: dashboard));
        _startRealtimeUpdates(dashboard);
      },
    );
  }

  Future<void> toggleFreezeCard(String cardId) async {
    final current = state;
    if (current is! DashboardLoaded) return;

    final card = current.dashboard.cards.firstWhere((c) => c.id == cardId);
    final result = await toggleFreezeCardUsecase(
      cardId: cardId,
      freeze: !card.isFrozen,
    );

    result.fold((failure) {}, (updatedCard) {
      final updatedCards = current.dashboard.cards
          .map((c) => c.id == updatedCard.id ? updatedCard : c)
          .toList();
      emit(
        current.copyWith(
          dashboard: current.dashboard.copyWith(cards: updatedCards),
        ),
      );
    });
  }

  void _startRealtimeUpdates(DashboardEntity seed) {
    _realtimeSubscription?.cancel();
    _realtimeSubscription = watchDashboardUpdatesUsecase(seed).listen((result) {
      result.fold((failure) {}, (updatedDashboard) {
        final current = state;
        if (current is DashboardLoaded) {
          emit(current.copyWith(dashboard: updatedDashboard, isLive: true));
        }
      });
    });
  }

  @override
  Future<void> close() {
    _realtimeSubscription?.cancel();
    return super.close();
  }
}
