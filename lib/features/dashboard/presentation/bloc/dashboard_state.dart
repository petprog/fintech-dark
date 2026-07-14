import 'package:equatable/equatable.dart';
import '../../domain/entities/dashboard_entity.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final DashboardEntity dashboard;

  final bool isRefreshing;

  final bool isLive;

  const DashboardLoaded({
    required this.dashboard,
    this.isRefreshing = false,
    this.isLive = false,
  });

  DashboardLoaded copyWith({
    DashboardEntity? dashboard,
    bool? isRefreshing,
    bool? isLive,
  }) {
    return DashboardLoaded(
      dashboard: dashboard ?? this.dashboard,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLive: isLive ?? this.isLive,
    );
  }

  @override
  List<Object?> get props => [dashboard, isRefreshing, isLive];
}

class DashboardError extends DashboardState {
  final String message;

  final DashboardEntity? lastKnownGood;

  const DashboardError(this.message, {this.lastKnownGood});

  @override
  List<Object?> get props => [message, lastKnownGood];
}
