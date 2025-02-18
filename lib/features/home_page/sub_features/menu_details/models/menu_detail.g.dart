// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MenuDetailAdapter extends TypeAdapter<MenuDetail> {
  @override
  final int typeId = 6;

  @override
  MenuDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuDetail(
      idMenu: fields[0] as int,
      nama: fields[1] as String,
      kategori: fields[2] as String,
      harga: fields[3] as int,
      deskripsi: fields[4] as String,
      foto: fields[5] as String,
      status: fields[6] as int,
      topping: (fields[7] as List?)?.cast<Topping>(),
      level: (fields[8] as List?)?.cast<Level>(),
    );
  }

  @override
  void write(BinaryWriter writer, MenuDetail obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.idMenu)
      ..writeByte(1)
      ..write(obj.nama)
      ..writeByte(2)
      ..write(obj.kategori)
      ..writeByte(3)
      ..write(obj.harga)
      ..writeByte(4)
      ..write(obj.deskripsi)
      ..writeByte(5)
      ..write(obj.foto)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.topping)
      ..writeByte(8)
      ..write(obj.level);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LevelAdapter extends TypeAdapter<Level> {
  @override
  final int typeId = 7;

  @override
  Level read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Level(
      idDetail: fields[0] as int,
      idMenu: fields[1] as int,
      keterangan: fields[2] as String,
      type: fields[3] as String,
      harga: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Level obj) {
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
      other is LevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ToppingAdapter extends TypeAdapter<Topping> {
  @override
  final int typeId = 8;

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
