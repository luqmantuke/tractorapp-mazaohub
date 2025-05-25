import 'package:intl/intl.dart';

class PriceFormatter {
  static String format(double? amount, {String currency = 'Tsh'}) {
    if (amount == null) return '0 $currency';

    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '',
      decimalDigits: 0,
    );

    return '${formatter.format(amount)} $currency';
  }

  static String formatCompact(double? amount, {String currency = 'Tsh'}) {
    if (amount == null) return '0 $currency';

    final formatter = NumberFormat.compactCurrency(
      locale: 'en_US',
      symbol: '',
      decimalDigits: 1,
    );

    return '${formatter.format(amount)} $currency';
  }

  static String formatInput(String value) {
    if (value.isEmpty) return '';

    // Remove any non-digit characters
    final cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanValue.isEmpty) return '';

    // Parse and format the number
    final number = int.tryParse(cleanValue);
    if (number == null) return '';

    return NumberFormat('#,###').format(number);
  }

  static int? parseAmount(String value) {
    if (value.isEmpty) return null;
    final cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleanValue);
  }
}
