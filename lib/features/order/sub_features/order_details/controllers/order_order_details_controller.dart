import 'package:flutter_java_code_app/features/order/sub_features/order_details/models/order_detail_model.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_details/repositories/order_details_repository.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:get/get.dart';

class OrderDetailsController extends GetxController {
  static OrderDetailsController get to => Get.find();

  final RxInt orderId = 0.obs;
  final Rx<OrderDetailModel?> orderItem = Rx<OrderDetailModel?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    final int? argsOrderId = Get.arguments?['orderId'] as int?;
    if (argsOrderId != null) {
      orderId.value = argsOrderId;
      getOrderDetails();
    }
  }

  Future<void> getOrderDetails() async {
    AppLogger.d('get order details : ${orderId.value}');
    isLoading.value = true;

    final result =
        await OrderDetailsRepository.fetchOrderDetails(orderId.value);

    result.fold(
      (failure) {
        AppLogger.e(failure.message);
        Get.snackbar("Error", failure.message);
      },
      (order) {
        orderItem.value = order;
      },
    );

    if ((orderItem.value?.detail.isNotEmpty ?? false)) {
      AppLogger.d(orderItem.value!.detail[0].idMenu.toString());
    }
    isLoading.value = false;
  }

  OrderDetailModel get foodItems {
    final order = orderItem.value;
    if (order == null) {
      throw Exception("Order details belum dimuat");
    }
    final filteredDetail = order.detail
        .where((menuItem) =>
            menuItem.kategori.toLowerCase() == 'makanan' ||
            menuItem.kategori.toLowerCase() == 'food')
        .toList();
    return OrderDetailModel(
      idOrder: order.idOrder,
      noStruk: order.noStruk,
      nama: order.nama,
      idVoucher: order.idVoucher,
      namaVoucher: order.namaVoucher,
      diskon: order.diskon,
      potongan: order.potongan,
      totalBayar: order.totalBayar,
      tanggal: order.tanggal,
      status: order.status,
      detail: filteredDetail,
    );
  }

  OrderDetailModel get drinkItems {
    final order = orderItem.value;
    if (order == null) {
      throw Exception("Order details belum dimuat");
    }
    final filteredDetail = order.detail
        .where((menuItem) =>
            menuItem.kategori.toLowerCase() == 'minuman' ||
            menuItem.kategori.toLowerCase() == 'drink')
        .toList();
    return OrderDetailModel(
      idOrder: order.idOrder,
      noStruk: order.noStruk,
      nama: order.nama,
      idVoucher: order.idVoucher,
      namaVoucher: order.namaVoucher,
      diskon: order.diskon,
      potongan: order.potongan,
      totalBayar: order.totalBayar,
      tanggal: order.tanggal,
      status: order.status,
      detail: filteredDetail,
    );
  }

  OrderDetailModel get snackItems {
    final order = orderItem.value;
    if (order == null) {
      throw Exception("Order details belum dimuat");
    }
    final filteredDetail = order.detail
        .where((menuItem) => menuItem.kategori.toLowerCase() == 'snack')
        .toList();
    return OrderDetailModel(
      idOrder: order.idOrder,
      noStruk: order.noStruk,
      nama: order.nama,
      idVoucher: order.idVoucher,
      namaVoucher: order.namaVoucher,
      diskon: order.diskon,
      potongan: order.potongan,
      totalBayar: order.totalBayar,
      tanggal: order.tanggal,
      status: order.status,
      detail: filteredDetail,
    );
  }
}
