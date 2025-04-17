import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canc_app/core/helpers/database/hive_helper.dart';
import '../../../data/models/visit_reminder_model.dart';
import 'visit_reminder_state.dart';

class VisitReminderCubit extends Cubit<VisitReminderState> {
  VisitReminderCubit() : super(VisitReminderState()) {
    loadReminders();
  }

  Future<void> loadReminders() async {
    try {
      emit(state.copyWith(isLoading: true));

      /// open the visit reminders box
      await HiveHelper.openVisitRemindersBox();

      /// get all the visit reminders
      final reminders = HiveHelper.getAllVisitReminders();
      emit(state.copyWith(
        reminders: reminders,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load reminders: ${e.toString()}',
        isLoading: false,
      ));
    }
  }

  Future<void> addVisitReminder(VisitReminderModel reminder) async {
    try {
      await HiveHelper.saveVisitReminder(reminder.id, reminder);
      final updatedReminders = [...state.reminders, reminder];
      emit(state.copyWith(reminders: updatedReminders, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to add reminder: $e',
        isLoading: false,
      ));
    }
  }

  Future<void> updateVisitReminder(VisitReminderModel reminder) async {
    try {
      await HiveHelper.saveVisitReminder(reminder.id, reminder);
      final updatedReminders = [...state.reminders];
      final index = updatedReminders.indexWhere((r) => r.id == reminder.id);
      if (index != -1) {
        updatedReminders[index] = reminder;
        emit(state.copyWith(reminders: updatedReminders, isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to update reminder: $e',
        isLoading: false,
      ));
    }
  }

  Future<void> deleteVisitReminder(String id) async {
    try {
      await HiveHelper.deleteVisitReminder(id);
      final updatedReminders =
          state.reminders.where((r) => r.id != id).toList();
      emit(state.copyWith(reminders: updatedReminders, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to delete reminder: $e',
        isLoading: false,
      ));
    }
  }

  List<VisitReminderModel> getUpcomingVisits() {
    return state.reminders
        .where((reminder) => reminder.date.isAfter(DateTime.now()))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  Future<void> toggleVisitReminder(String id) async {
    try {
      final updatedReminders = [...state.reminders];
      final index = updatedReminders.indexWhere((r) => r.id == id);
      if (index != -1) {
        final updatedReminder = updatedReminders[index].copyWith(
          isEnabled: !updatedReminders[index].isEnabled,
        );
        await HiveHelper.saveVisitReminder(id, updatedReminder);
        updatedReminders[index] = updatedReminder;
        emit(state.copyWith(reminders: updatedReminders));
      }
    } catch (e) {
      emit(state.copyWith(error: 'Failed to toggle reminder: $e'));
    }
  }
}
