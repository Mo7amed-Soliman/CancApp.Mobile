// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frequency_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FrequencyDetailsModelAdapter extends TypeAdapter<FrequencyDetailsModel> {
  @override
  final int typeId = HiveHelper.frequencyDetailsBoxID;

  @override
  FrequencyDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FrequencyDetailsModel(
      daysInterval: fields[0] as int?,
      daysOfWeek: (fields[1] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, FrequencyDetailsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.daysInterval)
      ..writeByte(1)
      ..write(obj.daysOfWeek);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FrequencyDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
