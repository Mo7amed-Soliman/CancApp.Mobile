// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frequency_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FrequencyAdapter extends TypeAdapter<Frequency> {
  @override
  final int typeId = 1;

  @override
  Frequency read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Frequency.everyDay;
      case 1:
        return Frequency.daysOfWeek;
      case 2:
        return Frequency.everyXDays;
      default:
        return Frequency.everyDay;
    }
  }

  @override
  void write(BinaryWriter writer, Frequency obj) {
    switch (obj) {
      case Frequency.everyDay:
        writer.writeByte(0);
        break;
      case Frequency.daysOfWeek:
        writer.writeByte(1);
        break;
      case Frequency.everyXDays:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FrequencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
