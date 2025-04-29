import 'package:canc_app/core/helpers/database/medication_cache_helper.dart';
import 'package:canc_app/users/patient/reminder/data/data_sources/medication_reminder_data_source.dart';
import 'package:canc_app/users/patient/reminder/data/models/medication_reminder_model.dart';

class MedicationReminderDataSourceImpl implements MedicationReminderDataSource {
  @override
  Future<List<MedicationReminderModel>> getAllReminders() async {
    return MedicationCacheHelper.getAllMedicationReminders();
  }

  @override
  Future<void> saveReminder(String id, MedicationReminderModel reminder) async {
    await MedicationCacheHelper.saveMedicationReminder(id, reminder);
  }

  @override
  Future<void> deleteReminder(String id) async {
    await MedicationCacheHelper.deleteMedicationReminder(id);
  }

  @override
  Future<void> openBox() async {
    await MedicationCacheHelper.init();
  }
}
