import 'package:flutter_java_code_app/features/checkout/controllers/checkout_controller.dart';
import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/controllers/checkout_voucher_controller.dart';
import 'package:get/get.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckoutController());
  }
}

class CheckoutVoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckoutVoucherController());
  }
}
