import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../features.dart';

part 'spending_point_model.freezed.dart';
part 'spending_point_model.g.dart';

@freezed
abstract class SpendingPointModel with _$SpendingPointModel {
  const factory SpendingPointModel({
    required String month,
    required int value,
  }) = _SpendingPointModel;

  factory SpendingPointModel.fromJson(Map<String, dynamic> json) =>
      _$SpendingPointModelFromJson(json);
}

extension SpendingPointModelMapper on SpendingPointModel {
  SpendingPointEntity toEntity() =>
      SpendingPointEntity(month: month, value: value);
}

extension SpendingPointEntityMapper on SpendingPointEntity {
  SpendingPointModel toModel() =>
      SpendingPointModel(month: month, value: value);
}
