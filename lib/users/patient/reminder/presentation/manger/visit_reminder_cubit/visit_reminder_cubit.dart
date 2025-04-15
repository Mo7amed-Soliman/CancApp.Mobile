import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/visit_reminder_model.dart';
import 'visit_reminder_state.dart';

class VisitReminderCubit extends Cubit<VisitReminderState> {
  VisitReminderCubit() : super(VisitReminderState()) {
    loadReminders();
  }

  Future<void> loadReminders() async {
    try {
      emit(state.copyWith(isLoading: true));
      // Simulating API call delay
      await Future.delayed(const Duration(seconds: 5));

      // Mock data
      final mockReminders = [
        VisitReminderModel(
          id: '1',
          doctorName: 'Dr. John Smith',
          examinationType: 'General Check-up',
          date: DateTime.now().add(const Duration(days: 7)),
          time: DateTime.now().add(const Duration(hours: 10)),
        ),
        VisitReminderModel(
          id: '2',
          doctorName: 'Dr. Sarah Johnson',
          examinationType: 'Follow-up',
          date: DateTime.now().add(const Duration(days: 14)),
          time: DateTime.now().add(const Duration(hours: 14, minutes: 30)),
        ),
      ];

      emit(state.copyWith(
        reminders: mockReminders,
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
      emit(state.copyWith(isLoading: true));
      // TODO: Save to local storage or API
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
      emit(state.copyWith(isLoading: true));
      final updatedReminders = [...state.reminders];
      final index = updatedReminders.indexWhere((r) => r.id == reminder.id);
      if (index != -1) {
        updatedReminders[index] = reminder;
        // TODO: Update in local storage or API
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
      emit(state.copyWith(isLoading: true));
      final updatedReminders =
          state.reminders.where((r) => r.id != id).toList();
      // TODO: Delete from local storage or API
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
        updatedReminders[index] = updatedReminders[index].copyWith(
          isEnabled: !updatedReminders[index].isEnabled,
        );
        // TODO: Update in local storage or API
        emit(state.copyWith(reminders: updatedReminders));
      }
    } catch (e) {
      emit(state.copyWith(error: 'Failed to toggle reminder: $e'));
    }
  }
}
