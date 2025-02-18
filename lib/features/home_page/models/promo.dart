import 'package:hive/hive.dart';

part 'promo.g.dart';

@HiveType(typeId: 2)
class Promo extends HiveObject {
  @HiveField(0)
  final int idPromo;

  @HiveField(1)
  final String nama;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final int? diskon;

  @HiveField(4)
  final int nominal;

  @HiveField(5)
  final int? kadaluarsa;

  @HiveField(6)
  final String syaratKetentuan;

  @HiveField(7)
  final String? foto;

  @HiveField(8)
  final int createdAt;

  @HiveField(9)
  final int createdBy;

  @HiveField(10)
  final int isDeleted;

  Promo({
    required this.idPromo,
    required this.nama,
    required this.type,
    this.diskon,
    required this.nominal,
    this.kadaluarsa,
    required this.syaratKetentuan,
    this.foto,
    required this.createdAt,
    required this.createdBy,
    required this.isDeleted,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      idPromo: json['id_promo'],
      nama: json['nama'],
      type: json['type'],
      diskon: json['diskon'],
      nominal: json['nominal'],
      kadaluarsa: json['kadaluarsa'],
      syaratKetentuan: json['syarat_ketentuan'],
      foto: json['foto'],
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      isDeleted: json['is_deleted'],
    );
  }
}
