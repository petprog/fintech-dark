import '../../../features.dart';

class QuickActionModel extends QuickActionEntity {
  const QuickActionModel({
    required super.id,
    required super.label,
    required super.iconName,
  });

  factory QuickActionModel.fromJson(Map<String, dynamic> json) {
    return QuickActionModel(
      id: json['id'] as String,
      label: json['label'] as String,
      iconName: json['iconName'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'iconName': iconName,
  };
}
