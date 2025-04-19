import 'package:canc_app/core/helpers/functions/is_arabic.dart';

/// A utility class for handling month-related functionality
class MonthHelper {
  /// Returns the short month name in English
  static String getMonthShortEn(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  /// Returns the short month name in Arabic
  static String getMonthShortAr(int month) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ];
    return months[month - 1];
  }

  /// Returns the short month name based on the current locale
  static String getMonthShort(int month) {
    return isArabic() ? getMonthShortAr(month) : getMonthShortEn(month);
  }

  /// Returns the full month name in English
  static String getMonthFullEn(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  /// Returns the full month name in Arabic
  static String getMonthFullAr(int month) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ];
    return months[month - 1];
  }

  /// Returns the full month name based on the current locale
  static String getMonthFull(int month) {
    return isArabic() ? getMonthFullAr(month) : getMonthFullEn(month);
  }
}
