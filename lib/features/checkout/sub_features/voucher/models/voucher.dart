import 'package:hive/hive.dart';

part 'voucher.g.dart';

@HiveType(typeId: 11)
class Voucher {
  @HiveField(0)
  final int idVoucher;

  @HiveField(1)
  final String nama;

  @HiveField(2)
  final int idUser;

  @HiveField(3)
  final String namaUser;

  @HiveField(4)
  final int nominal;

  @HiveField(5)
  final String infoVoucher;

  @HiveField(6)
  final DateTime periodeMulai;

  @HiveField(7)
  final DateTime periodeSelesai;

  @HiveField(8)
  final int type;

  @HiveField(9)
  final int status;

  @HiveField(10)
  final String catatan;

  Voucher({
    required this.idVoucher,
    required this.nama,
    required this.idUser,
    required this.namaUser,
    required this.nominal,
    required this.infoVoucher,
    required this.periodeMulai,
    required this.periodeSelesai,
    required this.type,
    required this.status,
    required this.catatan,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      idVoucher: json['id_voucher'] as int,
      nama: json['nama'] as String,
      idUser: json['id_user'] as int,
      namaUser: json['nama_user'] as String,
      nominal: json['nominal'] as int,
      infoVoucher: json['info_voucher'] as String,
      periodeMulai: DateTime.parse(json['periode_mulai'] as String),
      periodeSelesai: DateTime.parse(json['periode_selesai'] as String),
      type: json['type'] as int,
      status: json['status'] as int,
      catatan: json['catatan'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_voucher': idVoucher,
      'nama': nama,
      'id_user': idUser,
      'nama_user': namaUser,
      'nominal': nominal,
      'info_voucher': infoVoucher,
      'periode_mulai': periodeMulai.toIso8601String(),
      'periode_selesai': periodeSelesai.toIso8601String(),
      'type': type,
      'status': status,
      'catatan': catatan,
    };
  }
}
