import 'package:flutter_java_code_app/features/home_page/models/menu.dart';
import 'package:hive/hive.dart';

part 'menu_ui.g.dart';

@HiveType(typeId: 5)
class MenuUI extends HiveObject {
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
  int quantity;

  @HiveField(8)
  List<int>? topping;

  @HiveField(9)
  List<int>? level;

  @HiveField(10)
  String? note;

  MenuUI({
    required this.idMenu,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.foto,
    required this.status,
    this.quantity = 0,
    this.topping,
    this.level,
    this.note,
  });

  // create MenuUI from Menu data (without detail)
  factory MenuUI.fromMenu(Menu menu) {
    return MenuUI(
      idMenu: menu.idMenu,
      nama: menu.nama,
      kategori: menu.kategori,
      harga: menu.harga,
      deskripsi: menu.deskripsi,
      foto: menu.foto,
      status: menu.status,
      quantity: 0,
      topping: [],
      level: [],
      note: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMenu': idMenu,
      'nama': nama,
      'kategori': kategori,
      'harga': harga,
      'deskripsi': deskripsi,
      'foto': foto,
      'status': status,
      'quantity': quantity,
      'topping': topping,
      'level': level,
      'note': note,
    };
  }
}
