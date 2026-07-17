import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_entity.freezed.dart';

@freezed
abstract class CardEntity with _$CardEntity {
  const factory CardEntity({
    required String id,
    required String holderName,
    required String maskedNumber,
    required String validThru,
    required String cvv,
    required bool isVirtual,
    @Default(false) bool isFrozen,
  }) = _CardEntity;
}
