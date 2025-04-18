import 'package:dartz/dartz.dart';
import 'package:canc_app/core/services/visit_notification_service.dart';
import 'package:canc_app/users/patient/reminder/data/data_sources/visit_reminder_data_source.dart';
import 'package:canc_app/users/patient/reminder/data/models/visit_reminder_model.dart';
import 'package:canc_app/users/patient/reminder/data/repositories/visit_reminder_repository.dart';

class VisitReminderRepositoryImpl implements VisitReminderRepository {
  final VisitReminderDataSource _dataSource;
  List<VisitReminderModel> _cachedReminders = [];

  VisitReminderRepositoryImpl(this._dataSource);

  @override
  Future<Either<String, Unit>> initialize() async {
    try {
      await _dataSource.openBox();
      _cachedReminders = await _dataSource.getAllReminders();
      return const Right(unit);
    } catch (e) {
      return Left('Failed to initialize repository: $e');
    }
  }

  @override
  Future<Either<String, List<VisitReminderModel>>> getAllReminders() async {
    try {
      _cachedReminders = await _dataSource.getAllReminders();
      return Right(_cachedReminders);
    } catch (e) {
      return Left('Failed to get reminders: $e');
    }
  }

  @override
  Future<Either<String, Unit>> addReminder(VisitReminderModel reminder) async {
    try {
      await _dataSource.saveReminder(reminder.id, reminder);
      await VisitNotificationService.scheduleVisitReminder(reminder);
      _cachedReminders = await _dataSource.getAllReminders();
      return const Right(unit);
    } catch (e) {
      return Left('Failed to add reminder: $e');
    }
  }

  @override
  Future<Either<String, Unit>> updateReminder(
      VisitReminderModel reminder) async {
    try {
      await _dataSource.saveReminder(reminder.id, reminder);
      await VisitNotificationService.scheduleVisitReminder(reminder);
      _cachedReminders = await _dataSource.getAllReminders();
      return const Right(unit);
    } catch (e) {
      return Left('Failed to update reminder: $e');
    }
  }

  @override
  Future<Either<String, Unit>> deleteReminder(String id) async {
    try {
      await _dataSource.deleteReminder(id);
      await VisitNotificationService.cancelVisitReminder(id);
      _cachedReminders = await _dataSource.getAllReminders();
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

      if (updatedReminder.isEnabled) {
        await VisitNotificationService.scheduleVisitReminder(updatedReminder);
      } else {
        await VisitNotificationService.cancelVisitReminder(id);
      }

      _cachedReminders = await _dataSource.getAllReminders();
      return const Right(unit);
    } catch (e) {
      return Left('Failed to toggle reminder: $e');
    }
  }
}
