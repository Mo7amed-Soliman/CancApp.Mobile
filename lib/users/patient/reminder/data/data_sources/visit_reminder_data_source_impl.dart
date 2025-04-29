import 'package:canc_app/core/helpers/database/visit_cache_helper.dart';
import 'package:canc_app/users/patient/reminder/data/data_sources/visit_reminder_data_source.dart';
import 'package:canc_app/users/patient/reminder/data/models/visit_reminder_model.dart';

class VisitReminderDataSourceImpl implements VisitReminderDataSource {
  @override
  Future<List<VisitReminderModel>> getAllReminders() async {
    return VisitCacheHelper.getAllVisitReminders();
  }

  @override
  Future<void> saveReminder(String id, VisitReminderModel reminder) async {
    await VisitCacheHelper.saveVisitReminder(id, reminder);
  }

  @override
  Future<void> deleteReminder(String id) async {
    await VisitCacheHelper.deleteVisitReminder(id);
  }

  @override
  Future<void> openBox() async {
    await VisitCacheHelper.init();
  }
}
