// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_date.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitDateAdapter extends TypeAdapter<HabitDate> {
  @override
  final int typeId = 1;

  @override
  HabitDate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitDate(
      id: fields[2] as String,
      habitId: fields[0] as String,
      date: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HabitDate obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.habitId)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitDateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
