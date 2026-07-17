import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final _format = NumberFormat.currency(symbol: '\$');
  static String format(int cents) => _format.format(cents / 100);
}
