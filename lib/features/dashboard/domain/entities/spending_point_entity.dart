import 'package:freezed_annotation/freezed_annotation.dart';
part 'spending_point_entity.freezed.dart';

@freezed
abstract class SpendingPointEntity with _$SpendingPointEntity {
  const factory SpendingPointEntity({
    required String month,
    required double value,
  }) = _SpendingPointEntity;
}
