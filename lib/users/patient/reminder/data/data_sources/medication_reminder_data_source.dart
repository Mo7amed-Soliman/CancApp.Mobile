import 'package:canc_app/users/patient/reminder/data/models/medication_reminder_model.dart';

abstract class MedicationReminderDataSource {
  Future<List<MedicationReminderModel>> getAllReminders();
  Future<void> saveReminder(String id, MedicationReminderModel reminder);
  Future<void> deleteReminder(String id);
  Future<void> openBox();
}
