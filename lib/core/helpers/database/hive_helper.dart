import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:canc_app/users/patient/reminder/data/models/medication_reminder_model.dart';
import 'package:canc_app/users/patient/reminder/data/models/visit_reminder_model.dart';
import 'package:canc_app/users/patient/reminder/data/models/frequency_enum.dart';
import 'package:canc_app/users/patient/reminder/data/models/frequency_details_model.dart';

class HiveHelper {
  static const String medicationRemindersBox = 'medication_reminders';
  static const String visitRemindersBox = 'visit_reminders';
  static const String frequencyDetailsBox = 'frequency_details';
  static const String frequencyBox = 'frequency';
  static bool _isInitialized = false;

  static Future<void> init() async {
    if (_isInitialized) return;

    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);

    // Register adapters if they're not already registered
    Hive.registerAdapter(MedicationTypeAdapter());
    Hive.registerAdapter(MedicationReminderModelAdapter());
    Hive.registerAdapter(VisitReminderModelAdapter());
    Hive.registerAdapter(FrequencyAdapter());
    Hive.registerAdapter(FrequencyDetailsModelAdapter());

    _isInitialized = true;
  }

  static Future<void> openMedicationRemindersBox() async {
    // Open boxes
    await Hive.openBox<MedicationReminderModel>(medicationRemindersBox);
    await Hive.openBox<FrequencyDetailsModel>(frequencyDetailsBox);
    await Hive.openBox<Frequency>(frequencyBox);
  }

  static Future<void> openVisitRemindersBox() async {
    await Hive.openBox<VisitReminderModel>(visitRemindersBox);
  }

  static Box<MedicationReminderModel> getMedicationRemindersBox() {
    return Hive.box<MedicationReminderModel>(medicationRemindersBox);
  }

  static Box<VisitReminderModel> getVisitRemindersBox() {
    return Hive.box<VisitReminderModel>(visitRemindersBox);
  }

  static Future<void> saveMedicationReminder(
      String key, MedicationReminderModel value) async {
    final box = getMedicationRemindersBox();
    await box.put(key, value);
  }

  static Future<void> saveVisitReminder(
      String key, VisitReminderModel value) async {
    final box = getVisitRemindersBox();
    await box.put(key, value);
  }

  static MedicationReminderModel? getMedicationReminder(String key) {
    final box = getMedicationRemindersBox();
    return box.get(key);
  }

  static VisitReminderModel? getVisitReminder(String key) {
    final box = getVisitRemindersBox();
    return box.get(key);
  }

  static Future<void> deleteMedicationReminder(String key) async {
    final box = getMedicationRemindersBox();
    await box.delete(key);
  }

  static Future<void> deleteVisitReminder(String key) async {
    final box = getVisitRemindersBox();
    await box.delete(key);
  }

  static List<MedicationReminderModel> getAllMedicationReminders() {
    final box = getMedicationRemindersBox();
    return box.values.toList();
  }

  static List<VisitReminderModel> getAllVisitReminders() {
    final box = getVisitRemindersBox();
    return box.values.toList();
  }
}
