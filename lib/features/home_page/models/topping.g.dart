// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topping.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToppingAdapter extends TypeAdapter<Topping> {
  @override
  final int typeId = 7;

  @override
  Topping read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Topping(
      idDetail: fields[0] as int,
      idMenu: fields[1] as int,
      keterangan: fields[2] as String,
      type: fields[3] as String,
      harga: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Topping obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.idDetail)
      ..writeByte(1)
      ..write(obj.idMenu)
      ..writeByte(2)
      ..write(obj.keterangan)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.harga);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToppingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
