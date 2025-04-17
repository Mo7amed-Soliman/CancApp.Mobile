import 'package:canc_app/core/services/local_notifications_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canc_app/core/helpers/database/hive_helper.dart';
import '../../../data/models/medication_reminder_model.dart';
import '../../../../../../core/services/medication_notification_service.dart';
import 'medication_reminder_state.dart';

class MedicationReminderCubit extends Cubit<MedicationReminderState> {
  MedicationReminderCubit() : super(MedicationReminderState()) {
    loadReminders();
  }

  Future<void> loadReminders() async {
    try {
      emit(state.copyWith(isLoading: true));
      // To check if permission is granted
      /// Request Notification Permission

      bool granted =
          await LocalNotificationService.requestNotificationPermission();
      if (!granted) {
        await LocalNotificationService.checkNotificationPermission();
      }

      /// open the medication reminders box
      await HiveHelper.openMedicationRemindersBox();

      /// get all the medication reminders
      final reminders = HiveHelper.getAllMedicationReminders();

      emit(state.copyWith(reminders: reminders, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load reminders: $e',
        isLoading: false,
      ));
    }
  }

  Future<void> addMedicationReminder(MedicationReminderModel reminder) async {
    try {
      await HiveHelper.saveMedicationReminder(reminder.id, reminder);
      final updatedReminders = [...state.reminders, reminder];
      emit(state.copyWith(reminders: updatedReminders, isLoading: false));

      // Schedule notifications for the new reminder
      await MedicationNotificationService.scheduleMedicationReminder(reminder);
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to add reminder: $e',
        isLoading: false,
      ));
    }
  }

  Future<void> updateMedicationReminder(
      MedicationReminderModel reminder) async {
    try {
      await HiveHelper.saveMedicationReminder(reminder.id, reminder);
      final updatedReminders = [...state.reminders];
      final index = updatedReminders.indexWhere((r) => r.id == reminder.id);
      if (index != -1) {
        updatedReminders[index] = reminder;
        emit(state.copyWith(reminders: updatedReminders, isLoading: false));
      }
      // Update notifications for the modified reminder
      await MedicationNotificationService.scheduleMedicationReminder(reminder);
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to update reminder: $e',
        isLoading: false,
      ));
    }
  }

  Future<void> deleteMedicationReminder(String id) async {
    try {
      await HiveHelper.deleteMedicationReminder(id);

      final updatedReminders =
          state.reminders.where((r) => r.id != id).toList();
      emit(state.copyWith(reminders: updatedReminders, isLoading: false));
      // Cancel notifications for the deleted reminder
      await MedicationNotificationService.cancelMedicationReminder(id);
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to delete reminder: $e',
        isLoading: false,
      ));
    }
  }

  Future<void> toggleMedicationReminder(String id) async {
    try {
      final updatedReminders = [...state.reminders];
      final index = updatedReminders.indexWhere((r) => r.id == id);
      if (index != -1) {
        final updatedReminder = updatedReminders[index].copyWith(
          isEnabled: !updatedReminders[index].isEnabled,
        );
        await HiveHelper.saveMedicationReminder(id, updatedReminder);

        updatedReminders[index] = updatedReminder;
        emit(state.copyWith(reminders: updatedReminders));
        // Update notifications based on the new enabled state
        await MedicationNotificationService.scheduleMedicationReminder(
          updatedReminder,
        );
      }
    } catch (e) {
      emit(state.copyWith(error: 'Failed to toggle reminder: $e'));
    }
  }
}
