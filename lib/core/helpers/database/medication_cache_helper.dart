import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:canc_app/users/patient/reminder/data/models/medication_reminder_model.dart';
import 'package:canc_app/users/patient/reminder/data/models/frequency_enum.dart';
import 'package:canc_app/users/patient/reminder/data/models/frequency_details_model.dart';

class MedicationCacheHelper {
  static Future<void> init() async {
    // Open boxes
    await Future.wait([
      Hive.openBox<MedicationReminderModel>(HiveHelper.medicationRemindersBox),
      Hive.openBox<FrequencyDetailsModel>(HiveHelper.frequencyDetailsBox),
      Hive.openBox<Frequency>(HiveHelper.frequencyBox),
    ]);
  }

  static Box<MedicationReminderModel> getMedicationRemindersBox() {
    return Hive.box<MedicationReminderModel>(HiveHelper.medicationRemindersBox);
  }

  static Future<void> saveMedicationReminder(
    String key,
    MedicationReminderModel value,
  ) async {
    final box = getMedicationRemindersBox();
    await box.put(key, value);
  }

  static MedicationReminderModel? getMedicationReminder(String key) {
    final box = getMedicationRemindersBox();
    return box.get(key);
  }

  static Future<void> deleteMedicationReminder(String key) async {
    final box = getMedicationRemindersBox();
    await box.delete(key);
  }

  static List<MedicationReminderModel> getAllMedicationReminders() {
    final box = getMedicationRemindersBox();
    return box.values.toList();
  }
}
