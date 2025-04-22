import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:canc_app/users/patient/reminder/data/models/visit_reminder_model.dart';

class VisitCacheHelper {
  static Future<void> init() async {
    await Hive.openBox<VisitReminderModel>(HiveHelper.visitRemindersBox);
  }

  static Box<VisitReminderModel> getVisitRemindersBox() {
    return Hive.box<VisitReminderModel>(HiveHelper.visitRemindersBox);
  }

  static Future<void> saveVisitReminder(
    String key,
    VisitReminderModel value,
  ) async {
    final box = getVisitRemindersBox();
    await box.put(key, value);
  }

  static VisitReminderModel? getVisitReminder(String key) {
    final box = getVisitRemindersBox();
    return box.get(key);
  }

  static Future<void> deleteVisitReminder(String key) async {
    final box = getVisitRemindersBox();
    await box.delete(key);
  }

  static List<VisitReminderModel> getAllVisitReminders() {
    final box = getVisitRemindersBox();
    return box.values.toList();
  }
}
