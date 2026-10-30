import 'package:intl/intl.dart';

abstract class DateFormatter {
  /// e.g. "Fri, Oct 30, 3:45 PM" (localized order and digits)
  static String timeWithDate(DateTime value, {String? locale}) {
    return DateFormat.MMMEd(locale).add_jm().format(value.toLocal());
  }

  /// Use this if you want the timezone shown too
  static String timeWithDateAndZone(DateTime value, {String? locale}) {
    return DateFormat.MMMEd(locale).add_jmz().format(value.toLocal());
  }
}
