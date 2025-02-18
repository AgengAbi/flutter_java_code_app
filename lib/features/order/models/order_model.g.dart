// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderModelAdapter extends TypeAdapter<OrderModel> {
  @override
  final int typeId = 9;

  @override
  OrderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderModel(
      idOrder: fields[0] as int,
      noStruk: fields[1] as String,
      nama: fields[2] as String,
      totalBayar: fields[3] as int,
      tanggal: fields[4] as String,
      status: fields[5] as int,
      menu: (fields[6] as List).cast<MenuModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, OrderModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.idOrder)
      ..writeByte(1)
      ..write(obj.noStruk)
      ..writeByte(2)
      ..write(obj.nama)
      ..writeByte(3)
      ..write(obj.totalBayar)
      ..writeByte(4)
      ..write(obj.tanggal)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.menu);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MenuModelAdapter extends TypeAdapter<MenuModel> {
  @override
  final int typeId = 10;

  @override
  MenuModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuModel(
      idMenu: fields[0] as int,
      kategori: fields[1] as String,
      topping: fields[2] as String,
      nama: fields[3] as String,
      foto: fields[4] as String,
      jumlah: fields[5] as int,
      harga: fields[6] as String,
      total: fields[7] as int,
      catatan: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MenuModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.idMenu)
      ..writeByte(1)
      ..write(obj.kategori)
      ..writeByte(2)
      ..write(obj.topping)
      ..writeByte(3)
      ..write(obj.nama)
      ..writeByte(4)
      ..write(obj.foto)
      ..writeByte(5)
      ..write(obj.jumlah)
      ..writeByte(6)
      ..write(obj.harga)
      ..writeByte(7)
      ..write(obj.total)
      ..writeByte(8)
      ..write(obj.catatan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
