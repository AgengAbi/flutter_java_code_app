import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/features/checkout/repositories/checkout_repository.dart';
import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/controllers/checkout_voucher_controller.dart';
import 'package:flutter_java_code_app/features/checkout/view/components/finger_print_dialog.dart';
import 'package:flutter_java_code_app/features/checkout/view/components/order_success_dialog.dart';
import 'package:flutter_java_code_app/features/checkout/view/components/pin_dialog.dart';
import 'package:flutter_java_code_app/features/home_page/models/menu_ui.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_again/repositories/order_again_repository.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_details/models/order_detail_model.dart';
import 'package:flutter_java_code_app/shared/widgets/error_snack_bar.dart';
import 'package:flutter_java_code_app/utils/extensions/order_detail_extension.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_java_code_app/utils/functions/modal_route.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class OrderOrderAgainController extends GetxController {
  static OrderOrderAgainController get to => Get.find();

  final RxInt orderId = 0.obs;
  final Rx<OrderDetailModel?> orderItem = Rx<OrderDetailModel?>(null);
  final RxList<MenuUI> menuUIList = <MenuUI>[].obs;
  final RxBool isLoading = true.obs;
  static final LocalAuthentication localAuth = LocalAuthentication();

  @override
  void onInit() {
    super.onInit();
    final int? argsOrderId = Get.arguments?['orderId'] as int?;
    AppLogger.d('argsOrderId : $argsOrderId');
    if (argsOrderId != null) {
      orderId.value = argsOrderId;
      getOrderDetails();
    }
  }

  int getQuantity(MenuUI menu) {
    AppLogger.d(
        'Get quantity of menuUIListOrderAgain: ${menu.idMenu} - current quantity: ${menu.quantity}');
    final existingItem =
        menuUIList.firstWhereOrNull((m) => m.idMenu == menu.idMenu);
    return existingItem?.quantity ?? 0;
  }

  Future<void> getOrderDetails() async {
    isLoading.value = true;

    final result = await OrderAgainRepository.fetchOrderDetails(orderId.value);
    result.fold(
      (failure) {
        AppLogger.e(failure.message);
        Get.snackbar("Error", failure.message);
      },
      (order) {
        orderItem.value = order;
        // Konversi data menu ke format MenuUI dengan extension
        menuUIList.value = order.toMenuUIList();
      },
    );

    isLoading.value = false;
  }

  OrderDetailModel get foodItems {
    final order = orderItem.value;
    if (order == null) throw Exception("Order details belum dimuat");
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
    if (order == null) throw Exception("Order details belum dimuat");
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
    if (order == null) throw Exception("Order details belum dimuat");
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

  int get totalPrice =>
      menuUIList.fold(0, (prev, item) => prev + (item.harga * item.quantity));

  int get discountPrice => totalPrice * 20 ~/ 100;

  int get voucherDiscount {
    if (CheckoutVoucherController.selectedVoucherId.value != null) {
      try {
        final voucher = CheckoutVoucherController.vouchers.firstWhere(
          (v) =>
              v.idVoucher == CheckoutVoucherController.selectedVoucherId.value,
        );
        AppLogger.d(voucher.nominal.toString());
        return voucher.nominal;
      } catch (e) {
        return 0;
      }
    }
    return 0;
  }

  int get grandTotalPrice {
    final grand = totalPrice - discountPrice - voucherDiscount;
    return max(grand, 0);
  }

  static Future<bool> hasBiometrics() async {
    try {
      return await localAuth.canCheckBiometrics &&
          await localAuth.isDeviceSupported();
    } on PlatformException catch (e) {
      AppLogger.d(e.toString());
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await localAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      AppLogger.d(e.toString());
      return [];
    }
  }

  Future<void> verify() async {
    AppLogger.d(
        "Order List sebelum verifikasi: ${menuUIList.map((item) => item.toJson()).toList()}");
    final bool isBiometricAvailable = await hasBiometrics();
    final List<BiometricType> biometrics = await getBiometrics();
    AppLogger.d(biometrics.toString());
    if (isBiometricAvailable) {
      final String? authType = await showFingerprintDialog();
      if (authType == 'fingerprint') {
        final bool authenticated = await localAuth.authenticate(
          localizedReason:
              'Harap lakukan autentikasi untuk mengonfirmasi pesanan',
          options: const AuthenticationOptions(
            biometricOnly: true,
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
        if (authenticated) {
          submitOrder();
          showOrderSuccessDialog();
        }
      } else if (authType == 'pin') {
        await showPinDialog();
      }
    } else {
      await showPinDialog();
    }
  }

  Future<String?> showFingerprintDialog() async {
    // Pastikan modal checkout tertutup
    Get.until(ModalRoute.withName(Routes.orderOrderAgainRoute));
    final result = await Get.defaultDialog(
      title: '',
      content: const FingerprintDialog(),
    );
    return result;
  }

  Future<void> showPinDialog() async {
    Get.until(ModalRoute.withName(Routes.orderOrderAgainRoute));
    const userPin = '123456';
    final bool? authenticated = await Get.defaultDialog(
      title: '',
      content: const PinDialog(pin: userPin),
    );
    if (authenticated == true) {
      submitOrder();
      showOrderSuccessDialog();
    } else if (authenticated != null) {
      Get.until(ModalRoute.withName(Routes.orderOrderAgainRoute));
      Get.showSnackbar(ErrorSnackBar(
        title: 'Error',
        message: 'PIN already wrong 3 times. Please try again later.',
      ));
    }
  }

  Future<void> showOrderSuccessDialog() async {
    Get.until(ModalRoute.withName(Routes.orderOrderAgainRoute));
    await Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      content: const OrderSuccessDialog(),
    );
    // Setelah sukses, bersihkan order dan pindah ke main page
    menuUIList.clear();
    Get.offAllNamed(Routes.mainPageRoute);
  }

  Future<void> submitOrder() async {
    final user = LocalStorageService.getUser();
    final int idUser = user!.idUser;
    const int idVoucher = 1; // Contoh: id voucher default
    final orderData = createOrderData(
      orderList: menuUIList,
      idUser: idUser,
      idVoucher: idVoucher,
    );
    AppLogger.d(orderData.toString());
    final String resultMessage =
        await CheckoutRepository.createOrder(orderData);
    if (resultMessage.toLowerCase().contains('successfuly')) {
      Get.snackbar('Success', resultMessage);
    } else {
      Get.snackbar('Error', resultMessage);
    }
  }

  Map<String, dynamic> createOrderData({
    required List<MenuUI> orderList,
    required int idUser,
    required int idVoucher,
  }) {
    final List<Map<String, dynamic>> menuData = orderList.map((menu) {
      return {
        "id_menu": menu.idMenu,
        "harga": menu.harga,
        "level": menu.levelSelected?.idDetail,
        "topping": menu.toppingSelected != null
            ? menu.toppingSelected!.map((topping) => topping.idDetail).toList()
            : [],
        "jumlah": menu.quantity,
        "catatan": menu.note,
      };
    }).toList();
    return {
      "order": {
        "id_user": idUser,
        "id_voucher": idVoucher,
        "potongan": discountPrice,
        "total_bayar": grandTotalPrice,
      },
      "menu": menuData,
    };
  }

  void incrementQuantity(MenuUI menu) {
    AppLogger.d(
        'Increment quantity: ${menu.nama} - current quantity: ${menu.quantity}');
    if (menu.quantity == 0) {
      Get.toNamed(Routes.orderOrderAgainDetailsRoute,
          arguments: {'menuUI': menu});
      menu.quantity++;
      AppLogger.d(
          'Navigated to detail and incremented, new quantity: ${menu.quantity}');
    } else {
      menu.quantity++;
    }
    menuUIList.refresh();
  }

  void decrementQuantity(MenuUI menu) {
    if (menu.quantity > 0) {
      menu.quantity--;
      AppLogger.d('Quantity decremented to ${menu.quantity}');

      // if quantiy is 0, remove from order list
      if (menu.quantity == 0) {
        menu.note = '';
        menuUIList.removeWhere((m) => m.idMenu == menu.idMenu);
      }
    }
    menuUIList.refresh();
  }
}
