import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:canc_app/users/patient/reminder/data/data_sources/medication_reminder_data_source.dart';
import 'package:canc_app/users/patient/reminder/data/models/medication_reminder_model.dart';

class MedicationReminderDataSourceImpl implements MedicationReminderDataSource {
  @override
  Future<List<MedicationReminderModel>> getAllReminders() async {
    return HiveHelper.getAllMedicationReminders();
  }

  @override
  Future<void> saveReminder(String id, MedicationReminderModel reminder) async {
    await HiveHelper.saveMedicationReminder(id, reminder);
  }

  @override
  Future<void> deleteReminder(String id) async {
    await HiveHelper.deleteMedicationReminder(id);
  }

  @override
  Future<void> openBox() async {
    await HiveHelper.openMedicationRemindersBox();
  }
}
