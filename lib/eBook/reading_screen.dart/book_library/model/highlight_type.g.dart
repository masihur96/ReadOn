// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlight_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class highlighttypeAdapter extends TypeAdapter<highlight_type> {
  @override
  final int typeId = 2;

  @override
  highlight_type read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return highlight_type.color;
      case 1:
        return highlight_type.bold;
      case 2:
        return highlight_type.underline;
      case 3:
        return highlight_type.italic;
      default:
        return highlight_type.color;
    }
  }

  @override
  void write(BinaryWriter writer, highlight_type obj) {
    switch (obj) {
      case highlight_type.color:
        writer.writeByte(0);
        break;
      case highlight_type.bold:
        writer.writeByte(1);
        break;
      case highlight_type.underline:
        writer.writeByte(2);
        break;
      case highlight_type.italic:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is highlighttypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
