import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class VisitReminderModel extends Equatable {
  final String id;
  final String doctorName;
  final String examinationType;
  final DateTime date;
  final DateTime time;
  final bool isEnabled;

  VisitReminderModel({
    String? id,
    required this.doctorName,
    required this.examinationType,
    required this.date,
    required this.time,
    this.isEnabled = true,
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props =>
      [id, doctorName, examinationType, date, time, isEnabled];

  VisitReminderModel copyWith({
    String? id,
    String? doctorName,
    String? examinationType,
    DateTime? date,
    DateTime? time,
    bool? isEnabled,
  }) {
    return VisitReminderModel(
      id: id ?? this.id,
      doctorName: doctorName ?? this.doctorName,
      examinationType: examinationType ?? this.examinationType,
      date: date ?? this.date,
      time: time ?? this.time,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
