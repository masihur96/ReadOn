// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlight.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HighlightAdapter extends TypeAdapter<Highlight> {
  @override
  final int typeId = 1;

  @override
  Highlight read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Highlight(
      type: fields[5] as highlight_type,
      text: fields[4] as String?,
      color: fields[3] as int,
      baseOffset: fields[0] as int,
      extendOffset: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Highlight obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.baseOffset)
      ..writeByte(1)
      ..write(obj.extendOffset)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.text)
      ..writeByte(5)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HighlightAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
