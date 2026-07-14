import '../../../features.dart';

class SpendingPointModel extends SpendingPointEntity {
  const SpendingPointModel({required super.month, required super.value});

  factory SpendingPointModel.fromJson(Map<String, dynamic> json) {
    return SpendingPointModel(
      month: json['month'] as String,
      value: (json['value'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {'month': month, 'value': value};
}
