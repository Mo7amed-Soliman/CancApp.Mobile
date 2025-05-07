import '../../../data/models/medication_reminder_model.dart';

class MedicationReminderState {
  final List<MedicationReminderModel> reminders;
  final bool isLoading;
  final String? error;

  MedicationReminderState({
    this.reminders = const [],
    this.isLoading = false,
    this.error,
  });

  MedicationReminderState copyWith({
    List<MedicationReminderModel>? reminders,
    bool? isLoading,
    String? error,
  }) {
    return MedicationReminderState(
      reminders: reminders ?? this.reminders,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
