import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'card_settings_state.dart';

@injectable
class CardSettingsCubit extends Cubit<CardSettingsState> {
  CardSettingsCubit() : super(const CardSettingsState());

  void toggleChangePin(bool value) {
    emit(state.copyWith(changePinEnabled: value));
  }

  void toggleQrPayment(bool value) {
    emit(state.copyWith(qrPaymentEnabled: value));
  }

  void toggleOnlineShopping(bool value) {
    emit(state.copyWith(onlineShoppingEnabled: value));
  }

  void toggleTapPay(bool value) {
    emit(state.copyWith(tapPayEnabled: value));
  }

  void reset() {
    emit(const CardSettingsState());
  }
}
