import 'package:equatable/equatable.dart';

class QuickActionEntity extends Equatable {
  final String id;
  final String label;
  final String iconName;

  const QuickActionEntity({
    required this.id,
    required this.label,
    required this.iconName,
  });

  @override
  List<Object?> get props => [id, label, iconName];
}
