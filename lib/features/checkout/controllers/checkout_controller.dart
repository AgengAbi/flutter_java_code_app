import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_java_code_app/configs/routes/route.dart';
import 'package:flutter_java_code_app/features/checkout/repositories/checkout_repository.dart';
import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/controllers/checkout_voucher_controller.dart';
import 'package:flutter_java_code_app/features/checkout/view/components/finger_print_dialog.dart';
import 'package:flutter_java_code_app/features/checkout/view/components/order_success_dialog.dart';
import 'package:flutter_java_code_app/features/checkout/view/components/pin_dialog.dart';
import 'package:flutter_java_code_app/features/home_page/controllers/home_page_controller.dart';
import 'package:flutter_java_code_app/features/home_page/models/menu_ui.dart';
import 'package:flutter_java_code_app/shared/widgets/error_snack_bar.dart';
import 'package:flutter_java_code_app/utils/functions/app_logger.dart';
import 'package:flutter_java_code_app/utils/functions/modal_route.dart';
import 'package:flutter_java_code_app/utils/services/hive_service.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class CheckoutController extends GetxController {
  static CheckoutController get to => Get.find();

  // Discount dummy
  static final List<Map<String, String>> discountDummy = [
    {'title': 'Mengisi Survey', 'value': '10%'},
    {'title': 'Terlambat <3x', 'value': '10%'},
  ];

  // Get order list from HomePageController
  RxList<MenuUI> get orderList => HomePageController.to.orderList;

  // Get local authentication
  static final LocalAuthentication localAuth = LocalAuthentication();

  List<MenuUI> get foodItems => orderList
      .where((menu) => menu.kategori.toLowerCase() == 'makanan')
      .toList();

  List<MenuUI> get drinkItems => orderList
      .where((menu) => menu.kategori.toLowerCase() == 'minuman')
      .toList();

  List<MenuUI> get snackItems => orderList
      .where((menu) => menu.kategori.toLowerCase() == 'snack')
      .toList();

  void incrementQuantity(MenuUI menu) {
    HomePageController.to.incrementQuantity(menu);
    orderList.refresh();
  }

  void decrementQuantity(MenuUI menu) {
    HomePageController.to.decrementQuantity(menu);
    orderList.refresh();
  }

  int get totalPrice => orderList.fold(
      0, (prevTotal, item) => prevTotal + (item.harga * item.quantity));

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
        "Order List sebelum verifikasi: ${orderList.map((item) => item.toJson()).toList()}");

    // Check if biometric authentication is supported
    final bool isBiometricAvailable = await hasBiometrics();

    final List<BiometricType> biometrics = await getBiometrics();
    AppLogger.d(biometrics.toString());

    if (isBiometricAvailable) {
      // Open fingerprint dialog if supported
      final String? authType = await showFingerprintDialog();

      if (authType == 'fingerprint') {
        // Fingerprint authentication flow
        final bool authenticated = await localAuth.authenticate(
          localizedReason:
              'Harap lakukan autentikasi untuk mengonfirmasi pesanan'.tr,
          options: const AuthenticationOptions(
              biometricOnly: true, useErrorDialogs: true, stickyAuth: true),
        );

        // If succeed, order cart
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
    // Ensure all modal is closed before showing fingerprint dialog
    Get.until(ModalRoute.withName(Routes.checkoutRoute));
    final result = await Get.defaultDialog(
      title: '',
      content: const FingerprintDialog(),
    );

    return result;
  }

  Future<void> showPinDialog() async {
    // Ensure all modal is closed before showing PIN dialog
    Get.until(ModalRoute.withName(Routes.checkoutRoute));

    const userPin = '123456';

    final bool? authenticated = await Get.defaultDialog(
      title: '',
      content: const PinDialog(pin: userPin),
    );

    if (authenticated == true) {
      // If succeed, order cart
      submitOrder();
      showOrderSuccessDialog();
    } else if (authenticated != null) {
      // If failed 3 times, show order failed dialog
      Get.until(ModalRoute.withName(Routes.checkoutRoute));
      Get.showSnackbar(ErrorSnackBar(
        title: 'Error',
        message: 'PIN already wrong 3 times. Please try again later.',
      ));
    }
  }

  Future<void> showOrderSuccessDialog() async {
    Get.until(ModalRoute.withName(Routes.checkoutRoute));

    await Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      content: const OrderSuccessDialog(),
    );
    HomePageController.to.orderList.clear();
    Get.offAllNamed(Routes.mainPageRoute);
  }

  void submitOrder() async {
    final user = LocalStorageService.getUser();
    final int idUser = user!.idUser;
    const int idVoucher = 1;

    final orderData = createOrderData(
      orderList: orderList,
      idUser: idUser,
      idVoucher: idVoucher,
    );

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
    // final int totalPrice =
    //     orderList.fold(0, (prev, menu) => prev + (menu.harga * menu.quantity));
    // final int discountPrice = totalPrice * 20 ~/ 100;
    // final int grandTotalPrice = totalPrice - discountPrice;

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
}
