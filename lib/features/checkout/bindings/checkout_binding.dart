import 'package:flutter_java_code_app/features/checkout/controllers/checkout_controller.dart';
import 'package:get/get.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CheckoutController());
  }
}
