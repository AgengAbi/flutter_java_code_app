import 'package:flutter_java_code_app/features/home_page/models/menu_ui.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_details/models/order_detail_model.dart';

extension OrderDetailModelToMenuUI on OrderDetailModel {
  List<MenuUI> toMenuUIList() {
    return detail.map((orderDetail) {
      return MenuUI(
        idMenu: orderDetail.idMenu,
        nama: orderDetail.nama,
        kategori: orderDetail.kategori,
        harga: orderDetail.harga,
        // Karena data API OrderDetail tidak menyediakan 'deskripsi',
        // kita set sebagai string kosong atau bisa disesuaikan
        deskripsi: "",
        foto: orderDetail.foto,
        // Set default status, misalnya 1 (aktif)
        status: 1,
        // Gunakan jumlah sebagai quantity
        quantity: orderDetail.jumlah,
        // Data topping dan level tidak ada dari OrderDetail, jadi di-set null
        topping: null,
        level: null,
        levelSelected: null,
        toppingSelected: null,
        // Gunakan catatan sebagai note, jika ada
        note: orderDetail.catatan,
      );
    }).toList();
  }
}
