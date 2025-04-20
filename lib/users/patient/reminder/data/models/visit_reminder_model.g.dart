// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_reminder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VisitReminderModelAdapter extends TypeAdapter<VisitReminderModel> {
  @override
  final int typeId = 5;

  @override
  VisitReminderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VisitReminderModel(
      id: fields[0] as String?,
      doctorName: fields[1] as String,
      examinationType: fields[2] as String,
      date: fields[3] as DateTime,
      time: fields[4] as DateTime,
      isEnabled: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, VisitReminderModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.doctorName)
      ..writeByte(2)
      ..write(obj.examinationType)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.isEnabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisitReminderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
