import 'package:canc_app/core/services/local_notifications_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canc_app/users/patient/reminder/data/models/visit_reminder_model.dart';
import 'package:canc_app/users/patient/reminder/data/repositories/visit_reminder_repository.dart';
import 'visit_reminder_state.dart';

class VisitReminderCubit extends Cubit<VisitReminderState> {
  final VisitReminderRepository _repository;

  VisitReminderCubit(this._repository) : super(VisitReminderState()) {
    loadReminders();
  }

  Future<void> loadReminders() async {
    emit(state.copyWith(isLoading: true));

    // Request notification permissions
    bool granted =
        await LocalNotificationService.requestNotificationPermission();
    if (!granted) {
      await LocalNotificationService.checkNotificationPermission();
    }

    // Initialize repository
    final initResult = await _repository.initialize();
    initResult.fold(
      (error) => emit(state.copyWith(error: error, isLoading: false)),
      (_) async {
        // Get all reminders
        final remindersResult = await _repository.getAllReminders();
        remindersResult.fold(
          (error) => emit(state.copyWith(error: error, isLoading: false)),
          (reminders) =>
              emit(state.copyWith(reminders: reminders, isLoading: false)),
        );
      },
    );
  }

  Future<void> addVisitReminder(VisitReminderModel reminder) async {
    final result = await _repository.addReminder(reminder);
    result.fold(
      (error) => emit(state.copyWith(error: error, isLoading: false)),
      (success) {
        final updatedReminders = [...state.reminders, reminder];
        emit(state.copyWith(reminders: updatedReminders, isLoading: false));
      },
    );
  }

  Future<void> updateVisitReminder(VisitReminderModel reminder) async {
    final result = await _repository.updateReminder(reminder);
    result.fold(
      (error) => emit(state.copyWith(error: error, isLoading: false)),
      (success) {
        final updatedReminders = [...state.reminders];
        final index = updatedReminders.indexWhere((r) => r.id == reminder.id);
        if (index != -1) {
          updatedReminders[index] = reminder;
          emit(state.copyWith(reminders: updatedReminders, isLoading: false));
        }
      },
    );
  }

  Future<void> deleteVisitReminder(String id) async {
    final result = await _repository.deleteReminder(id);
    result.fold(
      (error) => emit(state.copyWith(error: error, isLoading: false)),
      (success) {
        final updatedReminders =
            state.reminders.where((r) => r.id != id).toList();
        emit(state.copyWith(reminders: updatedReminders, isLoading: false));
      },
    );
  }

  Future<void> toggleVisitReminder(String id) async {
    final result = await _repository.toggleReminder(id);
    result.fold(
      (error) => emit(state.copyWith(error: error, isLoading: false)),
      (success) {
        final updatedReminders = [...state.reminders];
        final index = updatedReminders.indexWhere((r) => r.id == id);
        if (index != -1) {
          final updatedReminder = updatedReminders[index].copyWith(
            isEnabled: !updatedReminders[index].isEnabled,
          );
          updatedReminders[index] = updatedReminder;
          emit(state.copyWith(reminders: updatedReminders, isLoading: false));
        }
      },
    );
  }
}
