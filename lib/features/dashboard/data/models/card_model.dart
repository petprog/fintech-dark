import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../features.dart';

part 'card_model.freezed.dart';
part 'card_model.g.dart';

@freezed
abstract class CardModel with _$CardModel {
  const factory CardModel({
    required String id,
    required String holderName,
    required String maskedNumber,
    required String validThru,
    required String cvv,
    required bool isVirtual,
    @Default(false) bool isFrozen,
  }) = _CardModel;

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);
}

extension CardModelMapper on CardModel {
  CardEntity toEntity() => CardEntity(
    id: id,
    holderName: holderName,
    maskedNumber: maskedNumber,
    validThru: validThru,
    cvv: cvv,
    isVirtual: isVirtual,
    isFrozen: isFrozen,
  );
}

extension CardEntityMapper on CardEntity {
  CardModel toModel() => CardModel(
    id: id,
    holderName: holderName,
    maskedNumber: maskedNumber,
    validThru: validThru,
    cvv: cvv,
    isVirtual: isVirtual,
    isFrozen: isFrozen,
  );
}
