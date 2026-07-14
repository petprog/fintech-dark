import 'package:equatable/equatable.dart';

class SpendingPointEntity extends Equatable {
  final String month;
  final double value;

  const SpendingPointEntity({required this.month, required this.value});

  @override
  List<Object?> get props => [month, value];
}
