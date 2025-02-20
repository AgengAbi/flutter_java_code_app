// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderDetailModelAdapter extends TypeAdapter<OrderDetailModel> {
  @override
  final int typeId = 10;

  @override
  OrderDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderDetailModel(
      idOrder: fields[0] as int,
      noStruk: fields[1] as String,
      nama: fields[2] as String,
      idVoucher: fields[3] as int,
      namaVoucher: fields[4] as String,
      diskon: fields[5] as int,
      potongan: fields[6] as int?,
      totalBayar: fields[7] as int,
      tanggal: fields[8] as String,
      status: fields[9] as int,
      detail: (fields[10] as List).cast<OrderDetail>(),
    );
  }

  @override
  void write(BinaryWriter writer, OrderDetailModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.idOrder)
      ..writeByte(1)
      ..write(obj.noStruk)
      ..writeByte(2)
      ..write(obj.nama)
      ..writeByte(3)
      ..write(obj.idVoucher)
      ..writeByte(4)
      ..write(obj.namaVoucher)
      ..writeByte(5)
      ..write(obj.diskon)
      ..writeByte(6)
      ..write(obj.potongan)
      ..writeByte(7)
      ..write(obj.totalBayar)
      ..writeByte(8)
      ..write(obj.tanggal)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.detail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrderDetailAdapter extends TypeAdapter<OrderDetail> {
  @override
  final int typeId = 1;

  @override
  OrderDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderDetail(
      idMenu: fields[0] as int,
      kategori: fields[1] as String,
      topping: fields[2] as String,
      nama: fields[3] as String,
      foto: fields[4] as String,
      jumlah: fields[5] as int,
      harga: fields[6] as int,
      total: fields[7] as int,
      catatan: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OrderDetail obj) {
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
      other is OrderDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
