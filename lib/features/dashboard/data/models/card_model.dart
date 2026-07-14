import '../../../features.dart';

class CardModel extends CardEntity {
  const CardModel({
    required super.id,
    required super.holderName,
    required super.maskedNumber,
    required super.validThru,
    required super.cvv,
    required super.isVirtual,
    super.isFrozen,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as String,
      holderName: json['holderName'] as String,
      maskedNumber: json['maskedNumber'] as String,
      validThru: json['validThru'] as String,
      cvv: json['cvv'] as String,
      isVirtual: json['isVirtual'] as bool,
      isFrozen: json['isFrozen'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'holderName': holderName,
    'maskedNumber': maskedNumber,
    'validThru': validThru,
    'cvv': cvv,
    'isVirtual': isVirtual,
    'isFrozen': isFrozen,
  };
}
