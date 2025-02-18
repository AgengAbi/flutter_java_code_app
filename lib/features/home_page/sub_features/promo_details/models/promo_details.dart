import 'package:hive/hive.dart';

part 'promo_details.g.dart';

@HiveType(typeId: 3)
class PromoDetails extends HiveObject {
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

  PromoDetails({
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

  factory PromoDetails.fromJson(Map<String, dynamic> json) {
    return PromoDetails(
      idPromo: json['id_promo'] ?? 0,
      nama: json['nama'] ?? '',
      type: json['type'] ?? '',
      diskon: json['diskon'] != null
          ? int.tryParse(json['diskon'].toString())
          : null,
      nominal: json['nominal'] ?? 0,
      kadaluarsa: json['kadaluarsa'] != null
          ? int.tryParse(json['kadaluarsa'].toString())
          : null,
      syaratKetentuan: json['syarat_ketentuan'] ?? '',
      foto: json['foto'],
      createdAt: json['created_at'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      isDeleted: json['is_deleted'] ?? 0,
    );
  }
}
