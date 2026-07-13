import 'package:intl/intl.dart';

abstract final class Formatters {
  static final NumberFormat _currency = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 0,
  );

  static final NumberFormat _currencyDecimal = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 2,
  );

  static String currency(num value) => _currency.format(value);

  static String currencyDecimal(num value) => _currencyDecimal.format(value);

  static String signedAmount(num value) {
    final formatted = _currency.format(value.abs());
    return value >= 0 ? '+ $formatted' : '- $formatted';
  }

  static String date(DateTime dateTime) =>
      DateFormat('hh:mm a · dd-MM-yyyy').format(dateTime);

  static String monthLabel(DateTime dateTime) => DateFormat('MMM').format(dateTime);
}
