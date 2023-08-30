// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dailyModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyModelAdapter extends TypeAdapter<DailyModel> {
  @override
  final int typeId = 1;

  @override
  DailyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DailyModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.alarm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
