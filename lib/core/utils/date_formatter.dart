import 'package:intl/intl.dart';

abstract class DateFormatter {
  static final String currentLocale = Intl.getCurrentLocale();

  static String timeWithDate(DateTime value) {
    final date = DateFormat.MMMEd(currentLocale).format(value);
    final time = DateFormat.jmz(currentLocale).format(value);
    return '$time $date';
  }
}
