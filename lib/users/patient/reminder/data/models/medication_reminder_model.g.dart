// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_reminder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicationReminderModelAdapter
    extends TypeAdapter<MedicationReminderModel> {
  @override
  final int typeId = HiveHelper.medicationBoxID;

  @override
  MedicationReminderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicationReminderModel(
      id: fields[0] as String,
      medicationName: fields[1] as String,
      type: fields[2] as MedicationType,
      frequency: fields[3] as Frequency,
      frequencyDetails: fields[4] as FrequencyDetailsModel,
      alarmTimes: (fields[5] as List).cast<DateTime>(),
      isEnabled: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MedicationReminderModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.medicationName)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.frequency)
      ..writeByte(4)
      ..write(obj.frequencyDetails)
      ..writeByte(5)
      ..write(obj.alarmTimes)
      ..writeByte(6)
      ..write(obj.isEnabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicationReminderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MedicationTypeAdapter extends TypeAdapter<MedicationType> {
  @override
  final int typeId = 0;

  @override
  MedicationType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MedicationType.pill;
      case 1:
        return MedicationType.injection;
      case 2:
        return MedicationType.liquid;
      case 3:
        return MedicationType.radiation;
      default:
        return MedicationType.pill;
    }
  }

  @override
  void write(BinaryWriter writer, MedicationType obj) {
    switch (obj) {
      case MedicationType.pill:
        writer.writeByte(0);
        break;
      case MedicationType.injection:
        writer.writeByte(1);
        break;
      case MedicationType.liquid:
        writer.writeByte(2);
        break;
      case MedicationType.radiation:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
