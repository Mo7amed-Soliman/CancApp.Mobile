import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/frequency_details_model.dart';
import '../../../data/models/frequency_enum.dart';
import '../../../data/models/medication_reminder_model.dart';
import 'medication_reminder_state.dart';

class MedicationReminderCubit extends Cubit<MedicationReminderState> {
  MedicationReminderCubit() : super(MedicationReminderState()) {
    loadReminders();
  }

  Future<void> loadReminders() async {
    try {
      emit(state.copyWith(isLoading: true));
      // Simulating API call delay
      // 5 seconds
      await Future.delayed(const Duration(seconds: 5));
      // TODO: Load reminders from local storage or API
      // For now, we'll use mock data
      final reminders = [
        MedicationReminderModel(
          id: '1',
          medicationName: 'Doxorubicin',
          type: MedicationType.pill,
          frequency: Frequency.everyDay,
          alarmTimes: [
            DateTime.now().add(const Duration(hours: 7)),
            DateTime.now().add(const Duration(hours: 13)),
            DateTime.now().add(const Duration(hours: 19)),
          ],
          frequencyDetails: const FrequencyDetailsModel(),
        ),
        MedicationReminderModel(
          id: '2',
          medicationName: 'Paclitaxel',
          type: MedicationType.injection,
          frequency: Frequency.daysOfWeek,
          alarmTimes: [
            DateTime.now().add(const Duration(hours: 10)),
            DateTime.now().add(const Duration(hours: 22)),
          ],
          frequencyDetails: const FrequencyDetailsModel(
            daysOfWeek: [1, 2, 3],
          ),
        ),
        MedicationReminderModel(
          id: '3',
          medicationName: 'Doxorubicin',
          type: MedicationType.radiation,
          frequency: Frequency.everyXDays,
          alarmTimes: [
            DateTime.now().add(const Duration(hours: 8)),
          ],
          frequencyDetails: const FrequencyDetailsModel(
            daysInterval: 3,
          ),
        ),
        MedicationReminderModel(
          id: '4',
          medicationName: 'Paclitaxel',
          type: MedicationType.liquid,
          frequency: Frequency.everyDay,
          alarmTimes: [
            DateTime.now().add(const Duration(hours: 9)),
            DateTime.now().add(const Duration(hours: 15)),
          ],
          frequencyDetails: const FrequencyDetailsModel(),
        ),
      ];
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

  Future<void> updateMedicationReminder(
      MedicationReminderModel reminder) async {
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

  Future<void> deleteMedicationReminder(String id) async {
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

  Future<void> toggleMedicationReminder(String id) async {
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

  List<MedicationReminderModel> getActiveReminders() {
    return state.reminders.where((reminder) => reminder.isEnabled).toList();
  }
}
