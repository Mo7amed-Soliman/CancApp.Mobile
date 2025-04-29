import 'package:canc_app/users/patient/reminder/data/models/visit_reminder_model.dart';

abstract class VisitReminderDataSource {
  Future<List<VisitReminderModel>> getAllReminders();
  Future<void> saveReminder(String id, VisitReminderModel reminder);
  Future<void> deleteReminder(String id);
  Future<void> openBox();
}
