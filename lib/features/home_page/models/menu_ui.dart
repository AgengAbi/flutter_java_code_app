import 'package:flutter_java_code_app/features/home_page/models/menu.dart';
import 'package:hive/hive.dart';

import 'level.dart';
import 'topping.dart';

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
  List<Topping>? topping;

  @HiveField(9)
  List<Level>? level;

  @HiveField(10)
  Level? levelSelected;

  @HiveField(11)
  List<Topping>? toppingSelected;

  @HiveField(12)
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
    this.levelSelected,
    this.toppingSelected,
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
      topping: null,
      level: null,
      levelSelected: null,
      toppingSelected: null,
      note: '',
    );
  }

  // Method for update form data
  void updateForm(MenuUI updated) {
    // quantity = updated.quantity;
    // topping = updated.topping;
    // level = updated.level;
    // levelSelected = updated.levelSelected;
    // toppingSelected = updated.toppingSelected;
    // note = updated.note;
    if (topping == null || topping!.isEmpty) {
      topping = updated.topping;
    }
    if (level == null || level!.isEmpty) {
      level = updated.level;
    }
  }

  // create MenuUI from response detail menu API
  factory MenuUI.fromDetailJson(Map<String, dynamic> json) {
    final data = json['data'];
    final menuJson = data['menu'];
    final toppingList = data['topping'] != null
        ? (data['topping'] as List).map((e) => Topping.fromJson(e)).toList()
        : null;
    final levelList = data['level'] != null
        ? (data['level'] as List).map((e) => Level.fromJson(e)).toList()
        : null;
    return MenuUI(
      idMenu: menuJson['id_menu'] is int
          ? menuJson['id_menu']
          : int.tryParse(menuJson['id_menu'].toString()) ?? 0,
      nama: menuJson['nama'],
      kategori: menuJson['kategori'],
      harga: menuJson['harga'] is int
          ? menuJson['harga']
          : int.tryParse(menuJson['harga'].toString()) ?? 0,
      deskripsi: menuJson['deskripsi'],
      foto: menuJson['foto'],
      status: menuJson['status'] is int
          ? menuJson['status']
          : int.tryParse(menuJson['status'].toString()) ?? 0,
      quantity: 0,
      topping: toppingList,
      level: levelList,
      levelSelected: null,
      toppingSelected: null,
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
      'topping': topping?.map((e) => e.toJson()).toList(),
      'level': level?.map((e) => e.toJson()).toList(),
      'levelSelected': levelSelected?.toJson(),
      'toppingSelected': toppingSelected?.map((e) => e.toJson()).toList(),
      'note': note,
    };
  }
}
