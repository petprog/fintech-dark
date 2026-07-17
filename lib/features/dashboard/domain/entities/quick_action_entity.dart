import 'package:freezed_annotation/freezed_annotation.dart';

part 'quick_action_entity.freezed.dart';

@freezed
abstract class QuickActionEntity with _$QuickActionEntity {
  const factory QuickActionEntity({
    required String id,
    required String label,
    required String iconName,
  }) = _QuickActionEntity;
}
