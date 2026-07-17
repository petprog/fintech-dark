import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../features.dart';

part 'quick_action_model.freezed.dart';
part 'quick_action_model.g.dart';

@freezed
abstract class QuickActionModel with _$QuickActionModel {
  const factory QuickActionModel({
    required String id,
    required String label,
    required String iconName,
  }) = _QuickActionModel;

  factory QuickActionModel.fromJson(Map<String, dynamic> json) =>
      _$QuickActionModelFromJson(json);
}

extension QuickActionModelMapper on QuickActionModel {
  QuickActionEntity toEntity() =>
      QuickActionEntity(id: id, label: label, iconName: iconName);
}

extension QuickActionEntityMapper on QuickActionEntity {
  QuickActionModel toModel() =>
      QuickActionModel(id: id, label: label, iconName: iconName);
}
