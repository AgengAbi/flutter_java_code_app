// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PromoAdapter extends TypeAdapter<Promo> {
  @override
  final int typeId = 2;

  @override
  Promo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Promo(
      idPromo: fields[0] as int,
      nama: fields[1] as String,
      type: fields[2] as String,
      diskon: fields[3] as int?,
      nominal: fields[4] as int,
      kadaluarsa: fields[5] as int?,
      syaratKetentuan: fields[6] as String,
      foto: fields[7] as String?,
      createdAt: fields[8] as int,
      createdBy: fields[9] as int,
      isDeleted: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Promo obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.idPromo)
      ..writeByte(1)
      ..write(obj.nama)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.diskon)
      ..writeByte(4)
      ..write(obj.nominal)
      ..writeByte(5)
      ..write(obj.kadaluarsa)
      ..writeByte(6)
      ..write(obj.syaratKetentuan)
      ..writeByte(7)
      ..write(obj.foto)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.createdBy)
      ..writeByte(10)
      ..write(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PromoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
