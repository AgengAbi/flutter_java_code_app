// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_ui.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MenuUIAdapter extends TypeAdapter<MenuUI> {
  @override
  final int typeId = 5;

  @override
  MenuUI read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuUI(
      idMenu: fields[0] as int,
      nama: fields[1] as String,
      kategori: fields[2] as String,
      harga: fields[3] as int,
      deskripsi: fields[4] as String,
      foto: fields[5] as String,
      status: fields[6] as int,
      quantity: fields[7] as int,
      topping: (fields[8] as List?)?.cast<int>(),
      level: (fields[9] as List?)?.cast<int>(),
      note: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MenuUI obj) {
    writer
      ..writeByte(11)
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
      ..write(obj.quantity)
      ..writeByte(8)
      ..write(obj.topping)
      ..writeByte(9)
      ..write(obj.level)
      ..writeByte(10)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuUIAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
