import 'package:hive/hive.dart';

part 'level.g.dart';

@HiveType(typeId: 6)
class Level extends HiveObject {
  @HiveField(0)
  final int idDetail;

  @HiveField(1)
  final int idMenu;

  @HiveField(2)
  final String keterangan;

  @HiveField(3)
  final String type;

  @HiveField(4)
  final int harga;

  Level({
    required this.idDetail,
    required this.idMenu,
    required this.keterangan,
    required this.type,
    required this.harga,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      idDetail: json['id_detail'] is int
          ? json['id_detail']
          : int.tryParse(json['id_detail'].toString()) ?? 0,
      idMenu: json['id_menu'] is int
          ? json['id_menu']
          : int.tryParse(json['id_menu'].toString()) ?? 0,
      keterangan: json['keterangan'],
      type: json['type'],
      harga: json['harga'] is int
          ? json['harga']
          : int.tryParse(json['harga'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_detail': idDetail,
      'id_menu': idMenu,
      'keterangan': keterangan,
      'type': type,
      'harga': harga,
    };
  }
}
