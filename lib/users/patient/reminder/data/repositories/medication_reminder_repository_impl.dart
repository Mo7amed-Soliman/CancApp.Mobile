import 'package:dartz/dartz.dart';
import 'package:canc_app/core/services/medication_notification_service.dart';
import 'package:canc_app/users/patient/reminder/data/data_sources/medication_reminder_data_source.dart';
import 'package:canc_app/users/patient/reminder/data/models/medication_reminder_model.dart';
import 'package:canc_app/users/patient/reminder/data/repositories/medication_reminder_repository.dart';

class MedicationReminderRepositoryImpl implements MedicationReminderRepository {
  final MedicationReminderDataSource _dataSource;

  MedicationReminderRepositoryImpl(this._dataSource);

  @override
  Future<Either<String, Unit>> initialize() async {
    try {
      await _dataSource.openBox();
      return const Right(unit);
    } catch (e) {
      return Left('Failed to initialize repository: $e');
    }
  }

  @override
  Future<Either<String, List<MedicationReminderModel>>>
      getAllReminders() async {
    try {
      final reminders = await _dataSource.getAllReminders();
      return Right(reminders);
    } catch (e) {
      return Left('Failed to get reminders: $e');
    }
  }

  @override
  Future<Either<String, Unit>> addReminder(
      MedicationReminderModel reminder) async {
    try {
      await _dataSource.saveReminder(reminder.id, reminder);
      await MedicationNotificationService.scheduleMedicationReminder(reminder);
      return const Right(unit);
    } catch (e) {
      return Left('Failed to add reminder: $e');
    }
  }

  @override
  Future<Either<String, Unit>> updateReminder(
      MedicationReminderModel reminder) async {
    try {
      await _dataSource.saveReminder(reminder.id, reminder);
      await MedicationNotificationService.scheduleMedicationReminder(reminder);
      return const Right(unit);
    } catch (e) {
      return Left('Failed to update reminder: $e');
    }
  }

  @override
  Future<Either<String, Unit>> deleteReminder(String id) async {
    try {
      await _dataSource.deleteReminder(id);
      await MedicationNotificationService.cancelMedicationReminder(id);
      return const Right(unit);
    } catch (e) {
      return Left('Failed to delete reminder: $e');
    }
  }

  @override
  Future<Either<String, Unit>> toggleReminder(String id) async {
    try {
      final reminders = await _dataSource.getAllReminders();
      final reminder = reminders.firstWhere((r) => r.id == id);
      final updatedReminder = reminder.copyWith(isEnabled: !reminder.isEnabled);
      await _dataSource.saveReminder(id, updatedReminder);
      await MedicationNotificationService.scheduleMedicationReminder(
          updatedReminder);
      return const Right(unit);
    } catch (e) {
      return Left('Failed to toggle reminder: $e');
    }
  }
}
