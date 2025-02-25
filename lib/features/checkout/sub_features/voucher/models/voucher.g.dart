// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VoucherAdapter extends TypeAdapter<Voucher> {
  @override
  final int typeId = 11;

  @override
  Voucher read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Voucher(
      idVoucher: fields[0] as int,
      nama: fields[1] as String,
      idUser: fields[2] as int,
      namaUser: fields[3] as String,
      nominal: fields[4] as int,
      infoVoucher: fields[5] as String,
      periodeMulai: fields[6] as DateTime,
      periodeSelesai: fields[7] as DateTime,
      type: fields[8] as int,
      status: fields[9] as int,
      catatan: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Voucher obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.idVoucher)
      ..writeByte(1)
      ..write(obj.nama)
      ..writeByte(2)
      ..write(obj.idUser)
      ..writeByte(3)
      ..write(obj.namaUser)
      ..writeByte(4)
      ..write(obj.nominal)
      ..writeByte(5)
      ..write(obj.infoVoucher)
      ..writeByte(6)
      ..write(obj.periodeMulai)
      ..writeByte(7)
      ..write(obj.periodeSelesai)
      ..writeByte(8)
      ..write(obj.type)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.catatan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VoucherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
