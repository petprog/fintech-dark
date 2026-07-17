import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/dashboard_entity.dart';

part 'dashboard_state.freezed.dart';

@freezed
sealed class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = DashboardInitial;

  const factory DashboardState.loading() = DashboardLoading;

  const factory DashboardState.loaded({
    required DashboardEntity dashboard,
    @Default(false) bool isRefreshing,
    @Default(false) bool isLive,
  }) = DashboardLoaded;

  const factory DashboardState.error(
    String message, {
    DashboardEntity? lastKnownGood,
  }) = DashboardError;
}
