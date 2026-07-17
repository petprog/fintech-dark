import 'package:intl/intl.dart';

abstract final class Formatters {
  static final NumberFormat _currency = NumberFormat.currency(
    locale: 'en_US',
    symbol: r'$',
    decimalDigits: 0,
  );
  static final NumberFormat _decimal = NumberFormat.decimalPattern('en_US');

  static String currency(num value) {
    return _currency.format(value);
  }

  static String noCurrency(num value) {
    return _decimal.format(value.round());
  }

  static String signedAmount(num value) {
    final formatted = currency(value.abs());
    return value >= 0 ? '+ $formatted' : '- $formatted';
  }

  static String signedAmount2(num value) {
    final formatted = noCurrency(value.abs());
    return value >= 0 ? '+ $formatted' : '- $formatted';
  }

  static String date(DateTime dateTime) =>
      DateFormat('hh:mm a · dd-MM-yyyy').format(dateTime);

  static String monthLabel(DateTime dateTime) =>
      DateFormat('MMM').format(dateTime);
}
