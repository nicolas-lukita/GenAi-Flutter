import 'package:intl/intl.dart';

String numberWithAbbreviation(double number) {
  if (number >= 1000000) {
    final double value = number / 1000000;
    return "${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}M";
  } else if (number >= 1000) {
    final double value = number / 1000;
    return "${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}K";
  } else {
    return number.toString();
  }
}

double setDecimal(double value, int decimal) {
  return double.parse(value.toStringAsFixed(decimal));
}

String numberWithCommas(double number) {
  NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
  return numberFormat.format(number);
}
