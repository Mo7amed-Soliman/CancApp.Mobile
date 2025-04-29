import 'package:canc_app/core/helpers/database/hive_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/generated/l10n.dart';
import 'package:hive/hive.dart';
import 'frequency_details_model.dart';
import 'frequency_enum.dart';

part 'medication_reminder_model.g.dart';

@HiveType(typeId: 0)
enum MedicationType {
  @HiveField(0)
  pill,
  @HiveField(1)
  injection,
  @HiveField(2)
  liquid,
  @HiveField(3)
  radiation;

  String displayName(BuildContext context) {
    switch (this) {
      case MedicationType.pill:
        return S.of(context).pill;
      case MedicationType.injection:
        return S.of(context).injection;
      case MedicationType.liquid:
        return S.of(context).liquid;
      case MedicationType.radiation:
        return S.of(context).radiation;
    }
  }
}

@HiveType(typeId: HiveHelper.medicationBoxID)
class MedicationReminderModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String medicationName;
  @HiveField(2)
  final MedicationType type;
  @HiveField(3)
  final Frequency frequency;
  @HiveField(4)
  final FrequencyDetailsModel frequencyDetails;
  @HiveField(5)
  final List<DateTime> alarmTimes;
  @HiveField(6)
  final bool isEnabled;

  const MedicationReminderModel({
    required this.id,
    required this.medicationName,
    required this.type,
    required this.frequency,
    required this.frequencyDetails,
    required this.alarmTimes,
    this.isEnabled = true,
  });

  @override
  List<Object?> get props => [
        id,
        medicationName,
        type,
        frequency,
        frequencyDetails,
        alarmTimes,
        isEnabled,
      ];

  MedicationReminderModel copyWith({
    String? id,
    String? medicationName,
    MedicationType? type,
    Frequency? frequency,
    FrequencyDetailsModel? frequencyDetails,
    List<DateTime>? alarmTimes,
    bool? isEnabled,
  }) {
    return MedicationReminderModel(
      id: id ?? this.id,
      medicationName: medicationName ?? this.medicationName,
      type: type ?? this.type,
      frequency: frequency ?? this.frequency,
      frequencyDetails: frequencyDetails ?? this.frequencyDetails,
      alarmTimes: alarmTimes ?? this.alarmTimes,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
