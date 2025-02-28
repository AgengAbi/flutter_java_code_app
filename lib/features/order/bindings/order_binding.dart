import 'package:flutter_java_code_app/features/checkout/sub_features/voucher/controllers/checkout_voucher_controller.dart';
import 'package:flutter_java_code_app/features/order/controllers/order_controller.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_again/controllers/order_order_again_controller.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_again_details/controllers/order_order_again_details_controller.dart';
import 'package:flutter_java_code_app/features/order/sub_features/order_details/controllers/order_order_details_controller.dart';
import 'package:get/get.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderController());
    Get.lazyPut(() => OrderDetailsController());
    Get.lazyPut(() => OrderOrderAgainController());
    Get.lazyPut(() => OrderOrderAgainDetailsController());
    Get.lazyPut(() => CheckoutVoucherController());
  }
}
