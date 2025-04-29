import 'package:dartz/dartz.dart';
import 'package:canc_app/users/patient/reminder/data/models/medication_reminder_model.dart';

abstract class MedicationReminderRepository {
  Future<Either<String, List<MedicationReminderModel>>> getAllReminders();
  Future<Either<String, Unit>> addReminder(MedicationReminderModel reminder);
  Future<Either<String, Unit>> updateReminder(MedicationReminderModel reminder);
  Future<Either<String, Unit>> deleteReminder(String id);
  Future<Either<String, Unit>> toggleReminder(String id);
  Future<Either<String, Unit>> initialize();
}
