import '../../../data/models/visit_reminder_model.dart';

class VisitReminderState {
  final List<VisitReminderModel> reminders;
  final bool isLoading;
  final String? error;

  VisitReminderState({
    this.reminders = const [],
    this.isLoading = false,
    this.error,
  });

  VisitReminderState copyWith({
    List<VisitReminderModel>? reminders,
    bool? isLoading,
    String? error,
  }) {
    return VisitReminderState(
      reminders: reminders ?? this.reminders,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
