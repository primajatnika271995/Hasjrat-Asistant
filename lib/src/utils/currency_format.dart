import 'package:intl/intl.dart';

class CurrencyFormat {
  final data = new NumberFormat.currency(
    name: '',
    symbol: '',
    locale: 'en_US',
    decimalDigits: 0,
  );
}
