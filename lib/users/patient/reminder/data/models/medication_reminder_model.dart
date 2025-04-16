import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:canc_app/generated/l10n.dart';
import 'frequency_details_model.dart';
import 'frequency_enum.dart';

enum MedicationType {
  pill,
  injection,
  liquid,
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

class MedicationReminderModel extends Equatable {
  final String id;
  final String medicationName;
  final MedicationType type;
  final Frequency frequency;
  final FrequencyDetailsModel frequencyDetails;
  final List<DateTime> alarmTimes;
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
