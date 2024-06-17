// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 0;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel()
      ..name = fields[0] as String
      ..category = fields[1] as String
      ..date = fields[2] as DateTime
      ..total2000 = fields[3] as int
      ..total1000 = fields[4] as int
      ..total500 = fields[5] as int
      ..total200 = fields[6] as int
      ..total100 = fields[7] as int
      ..total50 = fields[8] as int
      ..total20 = fields[9] as int
      ..total10 = fields[10] as int
      ..total5 = fields[11] as int
      ..total2 = fields[12] as int
      ..total1 = fields[13] as int
      ..totalSum = fields[14] as int;
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.total2000)
      ..writeByte(4)
      ..write(obj.total1000)
      ..writeByte(5)
      ..write(obj.total500)
      ..writeByte(6)
      ..write(obj.total200)
      ..writeByte(7)
      ..write(obj.total100)
      ..writeByte(8)
      ..write(obj.total50)
      ..writeByte(9)
      ..write(obj.total20)
      ..writeByte(10)
      ..write(obj.total10)
      ..writeByte(11)
      ..write(obj.total5)
      ..writeByte(12)
      ..write(obj.total2)
      ..writeByte(13)
      ..write(obj.total1)
      ..writeByte(14)
      ..write(obj.totalSum);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
