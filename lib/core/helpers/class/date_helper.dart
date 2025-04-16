import 'package:canc_app/core/helpers/functions/is_arabic.dart';
import 'package:canc_app/core/helpers/class/month_helper.dart';
import 'package:intl/intl.dart';

/// A utility class for handling date-related functionality
class DateHelper {
  /// Returns a formatted date string based on the current locale
  static String formatDate(DateTime date, {String? format}) {
    if (format != null) {
      return DateFormat(format).format(date);
    }

    return isArabic()
        ? DateFormat('yyyy/MM/dd').format(date)
        : DateFormat('dd/MM/yyyy').format(date);
  }

  /// Returns a formatted time string
  static String formatTime(DateTime time, {String format = 'HH:mm a'}) {
    return DateFormat(format).format(time);
  }

  /// Returns a formatted date and time string
  static String formatDateTime(DateTime dateTime,
      {String? dateFormat, String timeFormat = 'HH:mm a'}) {
    final date = formatDate(dateTime, format: dateFormat);
    final time = formatTime(dateTime, format: timeFormat);
    return '$date $time';
  }

  /// Returns a formatted short date string (e.g., "Jan 15, 2023")
  static String formatShortDate(DateTime date) {
    return isArabic()
        ? '${date.day} ${MonthHelper.getMonthShort(date.month)} ${date.year}'
        : '${MonthHelper.getMonthShort(date.month)} ${date.day}, ${date.year}';
  }

  /// Returns a formatted full date string (e.g., "January 15, 2023")
  static String formatFullDate(DateTime date) {
    return isArabic()
        ? '${date.day} ${MonthHelper.getMonthFull(date.month)} ${date.year}'
        : '${MonthHelper.getMonthFull(date.month)} ${date.day}, ${date.year}';
  }
}
