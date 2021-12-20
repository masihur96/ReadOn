// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_button.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MenuButtonAdapter extends TypeAdapter<HighlightMenuButton> {
  @override
  final int typeId = 4;

  @override
  HighlightMenuButton read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HighlightMenuButton(
      type: fields[1] as highlight_type,
      label: fields[2] as String,
      colorIntValue: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HighlightMenuButton obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.colorIntValue)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.label);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuButtonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
