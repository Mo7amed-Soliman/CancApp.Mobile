import 'package:canc_app/core/helpers/functions/is_arabic.dart';

/// A utility class that provides helper methods for week-related operations.
class WeekHelper {
  /// weekday in easy_date_timeline mon = 1, tue = 2, wed = 3, thu = 4, fri = 5, sat = 6, sun = 7
  static String getDayNameEn(int day) {
    switch (day) {
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
      case 7:
        return 'Sun';
      default:
        return 'Sun';
    }
  }

  static String getDayNameAr(int day) {
    switch (day) {
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
      case 7:
        return 'الأحد';
      default:
        return '';
    }
  }

  static String getDayName(int day) {
    return isArabic() ? getDayNameAr(day) : getDayNameEn(day);
  }

  /// Returns a list of day names for the selected days.
  ///
  /// [selectedDays] is a list of booleans indicating which days are selected.
  static List<String> getSelectedDayNames(List<bool> selectedDays) {
    List<String> dayNames = [];
    for (int i = 1; i <= selectedDays.length; i++) {
      if (selectedDays[i - 1]) {
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
