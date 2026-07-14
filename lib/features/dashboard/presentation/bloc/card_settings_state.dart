import 'package:equatable/equatable.dart';

class CardSettingsState extends Equatable {
  final bool changePinEnabled;
  final bool qrPaymentEnabled;
  final bool onlineShoppingEnabled;
  final bool tapPayEnabled;

  const CardSettingsState({
    this.changePinEnabled = false,
    this.qrPaymentEnabled = true,
    this.onlineShoppingEnabled = true,
    this.tapPayEnabled = true,
  });

  CardSettingsState copyWith({
    bool? changePinEnabled,
    bool? qrPaymentEnabled,
    bool? onlineShoppingEnabled,
    bool? tapPayEnabled,
  }) {
    return CardSettingsState(
      changePinEnabled: changePinEnabled ?? this.changePinEnabled,
      qrPaymentEnabled: qrPaymentEnabled ?? this.qrPaymentEnabled,
      onlineShoppingEnabled:
          onlineShoppingEnabled ?? this.onlineShoppingEnabled,
      tapPayEnabled: tapPayEnabled ?? this.tapPayEnabled,
    );
  }

  @override
  List<Object?> get props => [
    changePinEnabled,
    qrPaymentEnabled,
    onlineShoppingEnabled,
    tapPayEnabled,
  ];
}
