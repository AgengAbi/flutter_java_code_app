import 'package:hive/hive.dart';

part 'menu.g.dart';

@HiveType(typeId: 4)
class Menu extends HiveObject {
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

  Menu({
    required this.idMenu,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.foto,
    required this.status,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      idMenu: json['id_menu'] is int
          ? json['id_menu']
          : int.tryParse(json['id_menu'].toString()) ?? 0,
      nama: json['nama'],
      kategori: json['kategori'],
      harga: json['harga'] is int
          ? json['harga']
          : int.tryParse(json['harga'].toString()) ?? 0,
      deskripsi: json['deskripsi'],
      foto: json['foto'] ??
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
      status: json['status'] is int
          ? json['status']
          : int.tryParse(json['status'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_menu': idMenu,
      'nama': nama,
      'kategori': kategori,
      'harga': harga,
      'deskripsi': deskripsi,
      'foto': foto,
      'status': status,
    };
  }
}
