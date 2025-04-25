import 'package:flutter_java_code_app/features/checkout/controllers/checkout_controller.dart';
import 'package:flutter_java_code_app/features/home_page/controllers/home_page_controller.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/menu_details/controllers/home_page_menu_details_controller.dart';
import 'package:flutter_java_code_app/features/home_page/sub_features/promo_details/controllers/home_page_promo_details_controller.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomePageController());
  }
}

class HomePagePromoDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePagePromoDetailsController());
  }
}

class HomePageMenuDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageMenuDetailsController());
    Get.lazyPut(() => CheckoutController());
  }
}
