import 'package:hive/hive.dart';

part 'order_model.g.dart';

@HiveType(typeId: 9)
class OrderModel extends HiveObject {
  @HiveField(0)
  final int idOrder;

  @HiveField(1)
  final String noStruk;

  @HiveField(2)
  final String nama;

  @HiveField(3)
  final int totalBayar;

  @HiveField(4)
  final String tanggal;

  @HiveField(5)
  final int status;

  @HiveField(6)
  final List<MenuModel> menu;

  OrderModel({
    required this.idOrder,
    required this.noStruk,
    required this.nama,
    required this.totalBayar,
    required this.tanggal,
    required this.status,
    required this.menu,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      idOrder: json['id_order'],
      noStruk: json['no_struk'],
      nama: json['nama'],
      totalBayar: json['total_bayar'],
      tanggal: json['tanggal'],
      status: json['status'],
      menu: (json['menu'] as List).map((e) => MenuModel.fromJson(e)).toList(),
    );
  }
}

@HiveType(typeId: 10)
class MenuModel extends HiveObject {
  @HiveField(0)
  final int idMenu;

  @HiveField(1)
  final String kategori;

  @HiveField(2)
  final String topping;

  @HiveField(3)
  final String nama;

  @HiveField(4)
  final String foto;

  @HiveField(5)
  final int jumlah;

  @HiveField(6)
  final String harga;

  @HiveField(7)
  final int total;

  @HiveField(8)
  final String catatan;

  MenuModel({
    required this.idMenu,
    required this.kategori,
    required this.topping,
    required this.nama,
    required this.foto,
    required this.jumlah,
    required this.harga,
    required this.total,
    required this.catatan,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      idMenu: json['id_menu'],
      kategori: json['kategori'],
      topping: json['topping'],
      nama: json['nama'],
      foto: json['foto'],
      jumlah: json['jumlah'],
      harga: json['harga'],
      total: json['total'],
      catatan: json['catatan'],
    );
  }
}
