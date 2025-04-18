import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:canc_app/users/patient/reminder/data/data_sources/visit_reminder_data_source.dart';
import 'package:canc_app/users/patient/reminder/data/models/visit_reminder_model.dart';

class VisitReminderDataSourceImpl implements VisitReminderDataSource {
  @override
  Future<List<VisitReminderModel>> getAllReminders() async {
    return HiveHelper.getAllVisitReminders();
  }

  @override
  Future<void> saveReminder(String id, VisitReminderModel reminder) async {
    await HiveHelper.saveVisitReminder(id, reminder);
  }

  @override
  Future<void> deleteReminder(String id) async {
    await HiveHelper.deleteVisitReminder(id);
  }

  @override
  Future<void> openBox() async {
    await HiveHelper.openVisitRemindersBox();
  }
}
