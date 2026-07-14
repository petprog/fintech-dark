import 'package:equatable/equatable.dart';

class CardEntity extends Equatable {
  final String id;
  final String holderName;
  final String maskedNumber;
  final String validThru;
  final String cvv;
  final bool isVirtual;
  final bool isFrozen;

  const CardEntity({
    required this.id,
    required this.holderName,
    required this.maskedNumber,
    required this.validThru,
    required this.cvv,
    required this.isVirtual,
    this.isFrozen = false,
  });

  CardEntity copyWith({bool? isFrozen}) => CardEntity(
    id: id,
    holderName: holderName,
    maskedNumber: maskedNumber,
    validThru: validThru,
    cvv: cvv,
    isVirtual: isVirtual,
    isFrozen: isFrozen ?? this.isFrozen,
  );

  @override
  List<Object?> get props => [
    id,
    holderName,
    maskedNumber,
    validThru,
    cvv,
    isVirtual,
    isFrozen,
  ];
}
