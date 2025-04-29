import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'visit_reminder_model.g.dart';

@HiveType(typeId: HiveHelper.visitBoxID)
class VisitReminderModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String doctorName;
  @HiveField(2)
  final String examinationType;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final DateTime time;
  @HiveField(5)
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
