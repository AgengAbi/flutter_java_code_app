import 'package:hive/hive.dart';

part 'order_detail_model.g.dart';

@HiveType(typeId: 10)
class OrderDetailModel extends HiveObject {
  @HiveField(0)
  int idOrder;

  @HiveField(1)
  String noStruk;

  @HiveField(2)
  String nama;

  @HiveField(3)
  int idVoucher;

  @HiveField(4)
  String namaVoucher;

  @HiveField(5)
  int diskon;

  @HiveField(6)
  int? potongan;

  @HiveField(7)
  int totalBayar;

  @HiveField(8)
  String tanggal;

  @HiveField(9)
  int status;

  @HiveField(10)
  List<OrderDetail> detail;

  OrderDetailModel({
    required this.idOrder,
    required this.noStruk,
    required this.nama,
    required this.idVoucher,
    required this.namaVoucher,
    required this.diskon,
    this.potongan,
    required this.totalBayar,
    required this.tanggal,
    required this.status,
    required this.detail,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    final orderData = json['order'] as Map<String, dynamic>;
    final detailList = json['detail'] as List<dynamic>;

    return OrderDetailModel(
      idOrder: orderData['id_order'] as int,
      noStruk: orderData['no_struk'] as String,
      nama: orderData['nama'] as String,
      idVoucher: orderData['id_voucher'] as int,
      namaVoucher: orderData['nama_voucher'] == null
          ? ''
          : orderData['nama_voucher'] as String,
      diskon: orderData['diskon'] as int,
      potongan: orderData['potongan'] as int?,
      totalBayar: orderData['total_bayar'] as int,
      tanggal: orderData['tanggal'] as String,
      status: orderData['status'] as int,
      detail: detailList
          .map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

@HiveType(typeId: 1)
class OrderDetail extends HiveObject {
  @HiveField(0)
  int idMenu;

  @HiveField(1)
  String kategori;

  @HiveField(2)
  String topping;

  @HiveField(3)
  String nama;

  @HiveField(4)
  String foto;

  @HiveField(5)
  int jumlah;

  @HiveField(6)
  int harga;

  @HiveField(7)
  int total;

  @HiveField(8)
  String catatan;

  OrderDetail({
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

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      idMenu: json['id_menu'] as int,
      kategori: json['kategori'] as String,
      topping: json['topping'] is List
          ? (json['topping'] as List).join(', ')
          : json['topping'] as String,
      nama: json['nama'] as String,
      foto: json['foto'] as String,
      jumlah: json['jumlah'] is int
          ? json['jumlah'] as int
          : int.tryParse(json['jumlah'].toString()) ?? 0,
      harga: json['harga'] is int
          ? json['harga'] as int
          : int.tryParse(json['harga'].toString()) ?? 0,
      total: json['total'] is int
          ? json['total'] as int
          : int.tryParse(json['total'].toString()) ?? 0,
      catatan: json['catatan'] ?? '',
    );
  }
}
