// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      idUser: fields[0] as int,
      nama: fields[1] as String,
      email: fields[2] as String,
      tglLahir: fields[3] as String,
      alamat: fields[4] as String?,
      telepon: fields[5] as String,
      foto: fields[6] as String,
      ktp: fields[7] as String,
      pin: fields[8] as String,
      status: fields[9] as int,
      isCustomer: fields[10] as int,
      rolesId: fields[11] as int,
      roles: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.idUser)
      ..writeByte(1)
      ..write(obj.nama)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.tglLahir)
      ..writeByte(4)
      ..write(obj.alamat)
      ..writeByte(5)
      ..write(obj.telepon)
      ..writeByte(6)
      ..write(obj.foto)
      ..writeByte(7)
      ..write(obj.ktp)
      ..writeByte(8)
      ..write(obj.pin)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.isCustomer)
      ..writeByte(11)
      ..write(obj.rolesId)
      ..writeByte(12)
      ..write(obj.roles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
