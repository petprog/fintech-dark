import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_settings_state.freezed.dart';

@freezed
abstract class CardSettingsState with _$CardSettingsState {
  const factory CardSettingsState({
    @Default(false) bool changePinEnabled,
    @Default(true) bool qrPaymentEnabled,
    @Default(true) bool onlineShoppingEnabled,
    @Default(true) bool tapPayEnabled,
  }) = _CardSettingsState;
}
