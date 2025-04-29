import 'package:dartz/dartz.dart';
import 'package:canc_app/users/patient/reminder/data/models/visit_reminder_model.dart';

abstract class VisitReminderRepository {
  Future<Either<String, List<VisitReminderModel>>> getAllReminders();
  Future<Either<String, Unit>> addReminder(VisitReminderModel reminder);
  Future<Either<String, Unit>> updateReminder(VisitReminderModel reminder);
  Future<Either<String, Unit>> deleteReminder(String id);
  Future<Either<String, Unit>> toggleReminder(String id);
  Future<Either<String, Unit>> initialize();
}
