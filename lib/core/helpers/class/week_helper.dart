import 'package:canc_app/core/helpers/functions/is_arabic.dart';

/// A utility class that provides helper methods for week-related operations.
class WeekHelper {
  /// Returns the abbreviated name of a day in English.
  ///
  /// [day] is the day index (0-6, where 0 is Sunday).
  static String getDayNameEn(int day) {
    switch (day) {
      case 0:
        return 'Sun';
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      default:
        return '';
    }
  }

  /// Returns the name of a day in Arabic.
  ///
  /// [day] is the day index (0-6, where 0 is Sunday).
  static String getDayNameAr(int day) {
    switch (day) {
      case 0:
        return 'الأحد';
      case 1:
        return 'الاثنين';
      case 2:
        return 'الثلاثاء';
      case 3:
        return 'الأربعاء';
      case 4:
        return 'الخميس';
      case 5:
        return 'الجمعة';
      case 6:
        return 'السبت';
      default:
        return '';
    }
  }

  /// Returns the name of a day based on the current language.
  ///
  /// [day] is the day index (0-6, where 0 is Sunday).
  static String getDayName(int day) {
    return isArabic() ? getDayNameAr(day) : getDayNameEn(day);
  }

  /// Returns a list of day names for the selected days.
  ///
  /// [selectedDays] is a list of booleans indicating which days are selected.
  static List<String> getSelectedDayNames(List<bool> selectedDays) {
    List<String> dayNames = [];
    for (int i = 0; i < selectedDays.length; i++) {
      if (selectedDays[i]) {
        dayNames.add(getDayName(i));
      }
    }
    return dayNames;
  }

  /// Returns a comma-separated string of selected day names.
  ///
  /// [selectedDays] is a list of booleans indicating which days are selected.
  static String getSelectedDaysString(List<bool> selectedDays) {
    return getSelectedDayNames(selectedDays).join(', ');
  }
}
