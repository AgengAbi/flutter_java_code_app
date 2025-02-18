import 'package:hive/hive.dart';

part 'menu_detail.g.dart';

@HiveType(typeId: 6)
class MenuDetail extends HiveObject {
  @HiveField(0)
  final int idMenu;

  @HiveField(1)
  final String nama;

  @HiveField(2)
  final String kategori;

  @HiveField(3)
  final int harga;

  @HiveField(4)
  final String deskripsi;

  @HiveField(5)
  final String foto;

  @HiveField(6)
  final int status;

  @HiveField(7)
  final List<Topping>? topping;

  @HiveField(8)
  final List<Level>? level;

  MenuDetail({
    required this.idMenu,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.foto,
    required this.status,
    this.topping,
    this.level,
  });

  factory MenuDetail.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    if (data == null || data['menu'] == null) {
      throw Exception("Data atau Menu tidak ditemukan dalam response");
    }

    final menuJson = data['menu'] as Map<String, dynamic>;

    final toppingList = (data['topping'] as List<dynamic>?)
            ?.map((e) => Topping.fromJson(e))
            .toList() ??
        [];
    final levelList = (data['level'] as List<dynamic>?)
            ?.map((e) => Level.fromJson(e))
            .toList() ??
        [];

    return MenuDetail(
      idMenu: menuJson['id_menu'] is int
          ? menuJson['id_menu']
          : int.tryParse(menuJson['id_menu'].toString()) ?? 0,
      nama: menuJson['nama'] ?? '',
      kategori: menuJson['kategori'] ?? '',
      harga: menuJson['harga'] is int
          ? menuJson['harga']
          : int.tryParse(menuJson['harga'].toString()) ?? 0,
      deskripsi: menuJson['deskripsi'] ?? '',
      foto: menuJson['foto'] ?? '',
      status: menuJson['status'] is int
          ? menuJson['status']
          : int.tryParse(menuJson['status'].toString()) ?? 0,
      topping: toppingList,
      level: levelList,
    );
  }
}

@HiveType(typeId: 7)
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

@HiveType(typeId: 8)
class Topping extends HiveObject {
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

  Topping({
    required this.idDetail,
    required this.idMenu,
    required this.keterangan,
    required this.type,
    required this.harga,
  });

  factory Topping.fromJson(Map<String, dynamic> json) {
    return Topping(
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
